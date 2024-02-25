class Range<T extends num> {
  final T min;
  final T max;

  Range(this.min, this.max);

  double get median => (min + max) / 2;

  operator +(Range other) => Range(min + other.min, max + other.max);

  operator -(Range other) => Range(min - other.min, max - other.max);

  operator *(Range other) => Range(min * other.min, max * other.max);

  operator /(Range other) => Range(min / other.min, max / other.max);

  operator %(Range other) => Range(min % other.min, max % other.max);

  bool fits(Range other) => min <= other.median && max >= other.median;
}
