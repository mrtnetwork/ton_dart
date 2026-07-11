typedef CbBooleanConvertable<T> = T Function();

extension ExtQuickBool on bool {
  T? onTrue<T>(CbBooleanConvertable<T> onTrue) {
    if (this) {
      return onTrue();
    }
    return null;
  }
}
