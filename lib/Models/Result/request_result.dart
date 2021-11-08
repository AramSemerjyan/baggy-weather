/// This is generic model to get data from Networking
/// Some kind of reference to swift's Result<Any, Error?>
///
/// Here we can create a lot more like add status code, make error of type Error
/// But for this project I try to keep everything as simple as possible, not
/// because I don't to write it, but because it's 3:24 in the morning and I'm
/// starting to realise that there is not a lot of time left (is this correct way to write? O_o)
class RequestResult<T> {
  final T? data;
  final String? error;

  RequestResult({this.data, this.error});
}
