import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';
import 'package:plotwatch_flutter/src/shared/components/searchable_dropdown_field.dart';

/// Name, country and app language of the signed-in user (PROF-01–03).
/// The form values live in the page until saved; the saved profile lives in
/// the app-wide [ProfileBloc], which also sets the app language.
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  static const nameFieldKey = Key('profile.name');
  static const countryFieldKey = Key('profile.country');
  static const languageSelectorKey = Key('profile.language');
  static const saveButtonKey = Key('profile.save');
  static const signOutButtonKey = Key('profile.signOut');

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  Country? _country;
  String _locale = defaultLanguageCode;
  bool _filled = false;

  @override
  void initState() {
    super.initState();
    final state = context.read<ProfileBloc>().state;
    if (state.profile != null) {
      _fill(state.profile!);
    } else if (state.profileStatus != GenericStatus.loading) {
      context.read<ProfileBloc>().add(const ProfileEvent.fetchMe());
    }
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  void _fill(MyProfile profile) {
    _name.text = profile.fullName ?? '';
    _country = countries
        .where((country) => country.code == profile.countryCode)
        .firstOrNull;
    _locale = profile.locale;
    _filled = true;
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    context.read<ProfileBloc>().add(
      ProfileEvent.updateMe(
        fullName: _name.text.trim(),
        countryCode: _country?.code,
        locale: _locale,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final languageCode = Localizations.localeOf(context).languageCode;

    return ResponsiveScaffoldWrapper(
      props: ScaffoldWrapperProps(
        leading: BackButton(onPressed: () => context.goNamed(homeRouteName)),
        title: Text(l10n.profileTitle),
        resizeToAvoidBottomInset: true,
      ),
      mobileBody: BlocConsumer<ProfileBloc, ProfileState>(
        listenWhen: (previous, current) =>
            previous.profileStatus != current.profileStatus ||
            previous.profileActionStatus != current.profileActionStatus,
        listener: (context, state) {
          final bloc = context.read<ProfileBloc>();
          void resetFlowStep() => bloc.add(const ProfileEvent.resetFlowStep());

          if (state.profileStatus == GenericStatus.success &&
              !_filled &&
              state.profile != null) {
            setState(() => _fill(state.profile!));
          }
          if (state.profileStatus == GenericStatus.failure &&
              state.profileErrorMessage != null) {
            DialogUtils.handleFailure(context, state.profileErrorMessage!);
          }
          if (state.profileActionStatus == GenericStatus.success) {
            DialogUtils.handleSuccess(
              context,
              l10n.profileSaved,
              postActions: [resetFlowStep],
            );
          }
          if (state.profileActionStatus == GenericStatus.failure &&
              state.profileActionErrorMessage != null) {
            DialogUtils.handleFailure(
              context,
              state.profileActionErrorMessage!,
              postActions: [resetFlowStep],
            );
          }
        },
        buildWhen: (previous, current) =>
            previous.profileStatus != current.profileStatus ||
            previous.profileActionStatus != current.profileActionStatus ||
            previous.profile != current.profile,
        builder: (context, state) {
          if (state.profile == null &&
              state.profileStatus == GenericStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return AuthFormLayout(
            title: state.profile?.fullName ?? l10n.profileTitle,
            subtitle: state.profile?.email,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InputField(
                      key: ProfilePage.nameFieldKey,
                      controller: _name,
                      labelText: l10n.labelFullName,
                      validator: (value) => Validators.fullName(value, l10n),
                    ),
                    const Gap.vertical(height: AppSpacing.md),
                    SearchableDropdownField<Country>(
                      key: ProfilePage.countryFieldKey,
                      items: countries,
                      selectedValue: _country,
                      itemToString: (country) =>
                          '${country.flag} ${country.localizedName(languageCode)}',
                      onChanged: (country) =>
                          setState(() => _country = country),
                      labelText: l10n.labelCountry,
                      hintText: l10n.selectCountry,
                    ),
                    const Gap.vertical(height: AppSpacing.md),
                    Text(
                      l10n.labelLanguage,
                      style: context.textTheme.labelMedium,
                    ),
                    const Gap.vertical(height: 6),
                    SegmentedButton<String>(
                      key: ProfilePage.languageSelectorKey,
                      showSelectedIcon: false,
                      segments: [
                        ButtonSegment(
                          value: 'en',
                          label: Text(l10n.languageEnglish),
                        ),
                        ButtonSegment(
                          value: 'fr',
                          label: Text(l10n.languageFrench),
                        ),
                      ],
                      selected: {_locale},
                      onSelectionChanged: (selection) =>
                          setState(() => _locale = selection.first),
                    ),
                    const Gap.vertical(height: AppSpacing.lg),
                    SubmitButton(
                      key: ProfilePage.saveButtonKey,
                      label: l10n.saveChanges,
                      isLoading:
                          state.profileActionStatus == GenericStatus.loading,
                      onPressed: _save,
                    ),
                  ],
                ),
              ),
              const Gap.vertical(height: AppSpacing.md),
              PrimaryButton(
                key: ProfilePage.signOutButtonKey,
                withBg: false,
                width: double.infinity,
                onPressed: () => context.read<AuthenticationBloc>().add(
                  const AuthenticationEvent.signOutRequested(),
                ),
                child: Text(l10n.signOut),
              ),
            ],
          );
        },
      ),
    );
  }
}
