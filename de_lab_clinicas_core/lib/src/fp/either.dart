sealed class Either<L,
    R> {} //classe selada de tratamento de erros ela retorna um lefth ou right

class Left<L, R> extends Either<L, R> {
  final L value;
  Left(this.value);
}

class Right<L, R> extends Either<L, R> {
  final R value;
  Right(this.value);
}
