/// What a live stream reports (doc/04e M5-6): an item, or a change in the
/// connection, so the page can say "Reconnecting…".
sealed class LiveUpdate<T> {
  const LiveUpdate();
}

/// An item from the server, sent once.
final class LiveItem<T> extends LiveUpdate<T> {
  const LiveItem(this.item);

  final T item;

  @override
  bool operator ==(Object other) =>
      other is LiveItem<T> && identical(other.item, item);

  @override
  int get hashCode => identityHashCode(item);
}

/// The stream dropped; the next attempt is in [retryIn].
final class LiveReconnecting<T> extends LiveUpdate<T> {
  const LiveReconnecting(this.retryIn);

  final Duration retryIn;

  @override
  bool operator ==(Object other) =>
      other is LiveReconnecting<T> && other.retryIn == retryIn;

  @override
  int get hashCode => retryIn.hashCode;
}

/// Subscribed again after a drop.
final class LiveConnected<T> extends LiveUpdate<T> {
  const LiveConnected();

  @override
  bool operator ==(Object other) => other is LiveConnected<T>;

  @override
  int get hashCode => (LiveConnected<T>).hashCode;
}
