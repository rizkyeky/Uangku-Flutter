part of _utils;

class Gap {
  
  const Gap._constructor();
  
  static final SizedBox w4 = SizedBox(width: 4.w);
  static final SizedBox w8 = SizedBox(width: 8.w);
  static final SizedBox w12 = SizedBox(width: 12.w);
  static final SizedBox w16 = SizedBox(width: 16.w);
  static final SizedBox w24 = SizedBox(width: 24.w);
  static final SizedBox w32 = SizedBox(width: 32.w);
  
  static final SizedBox h4 = SizedBox(height: 4.h);
  static final SizedBox h8 = SizedBox(height: 8.h);
  static final SizedBox h12 = SizedBox(height: 12.h);
  static final SizedBox h16 = SizedBox(height: 16.h);
  static final SizedBox h24 = SizedBox(height: 24.h);
  static final SizedBox h32 = SizedBox(height: 32.h);
}

class GapPadding {
  
  const GapPadding._constructor();

  static const EdgeInsets zero = EdgeInsets.zero;
  static final EdgeInsets all8 = EdgeInsets.all(8.s);
  static final EdgeInsets all16 = EdgeInsets.all(16.s);
  static final EdgeInsets all16S = EdgeInsets.symmetric(
    horizontal: 16.w,
    vertical: 16.h
  );
  static final EdgeInsets h16v8 = EdgeInsets.symmetric(
    horizontal: 16.w,
    vertical: 8.h
  );

}