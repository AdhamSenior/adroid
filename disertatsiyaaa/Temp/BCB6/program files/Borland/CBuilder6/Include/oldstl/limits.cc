#ifndef __LIMITS_CC
#define __LIMITS_CC
#pragma option push -b -a8 -pc -Vx- -Ve- -w-inl -w-aus -w-sig
// -*- C++ -*-
#ifndef __STD_LIMITS
#define __STD_LIMITS

/***************************************************************************
 *
 * limits - Declarations for the Standard Library limits class
 *
 ***************************************************************************
 *
 * Copyright (c) 1994-1999 Rogue Wave Software, Inc.  All Rights Reserved.
 *
 * This computer software is owned by Rogue Wave Software, Inc. and is
 * protected by U.S. copyright laws and other laws and by international
 * treaties.  This computer software is furnished by Rogue Wave Software,
 * Inc. pursuant to a written license agreement and may be used, copied,
 * transmitted, and stored only in accordance with the terms of such
 * license and with the inclusion of the above copyright notice.  This
 * computer software or any other copies thereof may not be provided or
 * otherwise made available to any other person.
 *
 * U.S. Government Restricted Rights.  This computer software is provided
 * with Restricted Rights.  Use, duplication, or disclosure by the
 * Government is subject to restrictions as set forth in subparagraph (c)
 * (1) (ii) of The Rights in Technical Data and Computer Software clause
 * at DFARS 252.227-7013 or subparagraphs (c) (1) and (2) of the
 * Commercial Computer Software � Restricted Rights at 48 CFR 52.227-19,
 * as applicable.  Manufacturer is Rogue Wave Software, Inc., 5500
 * Flatiron Parkway, Boulder, Colorado 80301 USA.
 *
 **************************************************************************/

#include <stdcomp.h>
#include <rw/stddefs.h>
#include <rw/math.h>

#ifndef _RWSTD_NO_NEW_HEADER
#include <cfloat>
#include <climits>
#ifdef _RWSTD_REQUIRES_IEEEFP
#include <ieeefp.h>	// for siemens
#endif
#else
#include <float.h>
#ifdef _RWSTD_REQUIRES_IEEEFP
#include <ieeefp.h>	// for siemens
#endif
#include <oldstl/limits.h>
#endif

//
// Turn off the warnings under the MSVC compiler that
// say 'bool reserved for future use'
//
#ifdef _RWSTD_MSVC_BOOL_WARNING
#pragma warning ( disable : 4237 )
#endif
#ifndef _RWSTD_NO_NAMESPACE
namespace std {
#endif

#if defined(__OS2__) || defined(__MFC_COMPAT__)
#  ifdef max
#     undef max
#  endif
#  ifdef min
#     undef min
#  endif
#endif /*__OS2__ || __MFC_COMPAT__*/   

  enum float_round_style
  {
    round_indeterminate      = -1,
    round_toward_zero         =  0,
    round_to_nearest          =  1,
    round_toward_infinity     =  2,
    round_toward_neg_infinity =  3
  };

  enum float_denorm_style
  {
    denorm_indeterminate = -1,
    denorm_absent = 0,
    denorm_present = 1
  };

#if !defined(_RWSTD_NO_STI_SIMPLE)
#define __RW_INIT(n) = n
#else
#define __RW_INIT(n) /**/
#endif

//**********************************************************************
//
// Assumptions made in this implementation:
//
//   1) numeric_limits<int>::radix equals numeric_limits<T>::radix
//      for all integral T specialized in this file.
//
//   2) numeric_limits<int>::is_modulo equals numeric_limits<T>::is_modulo
//      for all signed integral T specialized in this file, except
//      numeric_limits<bool>::is_modulo, which is assumed to be false.
//
//   3) numeric_limts<T>::traps == false for all builtin integral T.
//
// Does there exist a machine for which these aren't true?
//
//**********************************************************************
//**********************************************************************
//
// If your compiler allows in-class initialization of static const data
// members of integral type, then look for all lines having a comment of
// the form
//
//       // VENDOR
//
// and set the value on that line to the proper one for your environment.
//
// If your compiler does NOT allow in-class initialization of static const
// data members of integral type, then you'll need to set the values in
// stdlib/src/limits/limits.cpp so they're properly archived into the
// Standard Library.
//
//**********************************************************************
  template <class T>
  class _RWSTDExportTemplate numeric_limits;

//
// Specialization for float.
//

  _RWSTD_TEMPLATE
  class _RWSTDExport numeric_limits<float>
  {
  public:

    static const bool _RWSTDExportTemplate is_specialized __RW_INIT(true);

    static inline float min ()  _RWSTD_INLINE_NO_THROW { return FLT_MIN; }
    static inline float max ()  _RWSTD_INLINE_NO_THROW { return FLT_MAX; }

    static const _RWSTDExportTemplate int digits   __RW_INIT(FLT_MANT_DIG);
    static const _RWSTDExportTemplate int digits10 __RW_INIT(FLT_DIG);

    static const bool _RWSTDExportTemplate is_signed  __RW_INIT(true);
    static const bool _RWSTDExportTemplate is_integer __RW_INIT(false);
    static const bool _RWSTDExportTemplate is_exact   __RW_INIT(false);

    static const  int _RWSTDExportTemplate radix __RW_INIT(FLT_RADIX);

    static inline float epsilon () _RWSTD_INLINE_NO_THROW { return FLT_EPSILON; }
    static float _RWSTDExportTemplate round_error    () _RWSTD_INLINE_NO_THROW;

    static const int _RWSTDExportTemplate min_exponent   __RW_INIT(FLT_MIN_EXP);
    static const int _RWSTDExportTemplate min_exponent10 __RW_INIT(FLT_MIN_10_EXP);
    static const int _RWSTDExportTemplate max_exponent   __RW_INIT(FLT_MAX_EXP);
    static const int _RWSTDExportTemplate max_exponent10 __RW_INIT(FLT_MAX_10_EXP);

    static const bool _RWSTDExportTemplate has_infinity      __RW_INIT(true);            // VENDOR
    static const bool _RWSTDExportTemplate has_quiet_NaN     __RW_INIT(true);            // VENDOR
    static const bool _RWSTDExportTemplate has_signaling_NaN __RW_INIT(true);            // VENDOR
    static const float_denorm_style _RWSTDExportTemplate has_denorm        __RW_INIT(denorm_indeterminate);            // VENDOR
    static const bool _RWSTDExportTemplate has_denorm_loss   __RW_INIT(false);            // VENDOR

    static float infinity      () _RWSTD_INLINE_NO_THROW;
    static float quiet_NaN     () _RWSTD_INLINE_NO_THROW;
    static float signaling_NaN () _RWSTD_INLINE_NO_THROW;
    static float denorm_min    () _RWSTD_INLINE_NO_THROW;

    static const bool _RWSTDExportTemplate is_iec559  __RW_INIT(false);                   // VENDOR
    static const bool _RWSTDExportTemplate is_bounded __RW_INIT(true);
    static const bool _RWSTDExportTemplate is_modulo  __RW_INIT(false);                   // VENDOR

    static const bool _RWSTDExportTemplate traps           __RW_INIT(false);              // VENDOR
    static const bool _RWSTDExportTemplate tinyness_before __RW_INIT(false);              // VENDOR

#ifndef _RWSTD_FLT_ROUNDS_IS_CONSTANT
    static const float_round_style _RWSTDExportTemplate round_style;
#else
    static const float_round_style _RWSTDExportTemplate round_style __RW_INIT(_RWSTD_STATIC_CAST(float_round_style,FLT_ROUNDS));
#endif
  };

//
// Specialization for double.
//

  _RWSTD_TEMPLATE
  class _RWSTDExport numeric_limits<double>
  {
  public:

    static const bool _RWSTDExportTemplate is_specialized  __RW_INIT(true);

    static inline double min ()  _RWSTD_INLINE_NO_THROW { return DBL_MIN; }
    static inline double max ()  _RWSTD_INLINE_NO_THROW { return DBL_MAX; }

    static const int _RWSTDExportTemplate digits   __RW_INIT(DBL_MANT_DIG);
    static const int _RWSTDExportTemplate digits10 __RW_INIT(DBL_DIG);

    static const bool _RWSTDExportTemplate is_signed  __RW_INIT(true);
    static const bool _RWSTDExportTemplate is_integer __RW_INIT(false);
    static const bool _RWSTDExportTemplate is_exact   __RW_INIT(false);

    static const int _RWSTDExportTemplate radix __RW_INIT(FLT_RADIX);

    static inline double epsilon () _RWSTD_INLINE_NO_THROW { return DBL_EPSILON; }
    static double round_error    () _RWSTD_INLINE_NO_THROW;

    static const int _RWSTDExportTemplate min_exponent   __RW_INIT(DBL_MIN_EXP);
    static const int _RWSTDExportTemplate min_exponent10 __RW_INIT(DBL_MIN_10_EXP);
    static const int _RWSTDExportTemplate max_exponent   __RW_INIT(DBL_MAX_EXP);
    static const int _RWSTDExportTemplate max_exponent10 __RW_INIT(DBL_MAX_10_EXP);

    static const bool _RWSTDExportTemplate has_infinity      __RW_INIT(true);            // VENDOR
    static const bool _RWSTDExportTemplate has_quiet_NaN     __RW_INIT(true);            // VENDOR
    static const bool _RWSTDExportTemplate has_signaling_NaN __RW_INIT(true);            // VENDOR
    static const float_denorm_style _RWSTDExportTemplate has_denorm        __RW_INIT(denorm_indeterminate);            // VENDOR
    static const bool _RWSTDExportTemplate has_denorm_loss   __RW_INIT(false);            // VENDOR

    static double infinity      () _RWSTD_INLINE_NO_THROW;
    static double quiet_NaN     () _RWSTD_INLINE_NO_THROW;
    static double signaling_NaN () _RWSTD_INLINE_NO_THROW;
    static double denorm_min    () _RWSTD_INLINE_NO_THROW;

    static const bool _RWSTDExportTemplate is_iec559  __RW_INIT(false);                   // VENDOR
    static const bool _RWSTDExportTemplate is_bounded __RW_INIT(true);
    static const bool _RWSTDExportTemplate is_modulo  __RW_INIT(false);                   // VENDOR

    static const bool _RWSTDExportTemplate traps           __RW_INIT(false);              // VENDOR
    static const bool _RWSTDExportTemplate tinyness_before __RW_INIT(false);              // VENDOR

#ifndef _RWSTD_FLT_ROUNDS_IS_CONSTANT
    static const float_round_style _RWSTDExportTemplate round_style;
#else
    static const float_round_style _RWSTDExportTemplate round_style __RW_INIT(_RWSTD_STATIC_CAST(float_round_style,FLT_ROUNDS));
#endif
  };

//
// Specialization for long double.
//

#ifndef _RWSTD_NO_LONGDOUBLE

  _RWSTD_TEMPLATE
  class _RWSTDExport numeric_limits<long double>
  {
  public:

    static const bool _RWSTDExportTemplate is_specialized __RW_INIT(true);

    static inline long double min () _RWSTD_INLINE_NO_THROW { return LDBL_MIN; } 
    static inline long double max () _RWSTD_INLINE_NO_THROW { return LDBL_MAX; }

    static const int _RWSTDExportTemplate digits   __RW_INIT(LDBL_MANT_DIG);
    static const int _RWSTDExportTemplate digits10 __RW_INIT(LDBL_DIG);

    static const bool _RWSTDExportTemplate is_signed  __RW_INIT(true);
    static const bool _RWSTDExportTemplate is_integer __RW_INIT(false);
    static const bool _RWSTDExportTemplate is_exact   __RW_INIT(false);

    static const int _RWSTDExportTemplate radix __RW_INIT(FLT_RADIX);

    static inline long double epsilon () _RWSTD_INLINE_NO_THROW { return LDBL_EPSILON; }
    static long double round_error    () _RWSTD_INLINE_NO_THROW;

    static const int _RWSTDExportTemplate min_exponent   __RW_INIT(LDBL_MIN_EXP);
    static const int _RWSTDExportTemplate min_exponent10 __RW_INIT(LDBL_MIN_10_EXP);
    static const int _RWSTDExportTemplate max_exponent   __RW_INIT(LDBL_MAX_EXP);
    static const int _RWSTDExportTemplate max_exponent10 __RW_INIT(LDBL_MAX_10_EXP);

    static const bool _RWSTDExportTemplate has_infinity      __RW_INIT(true);            // VENDOR
    static const bool _RWSTDExportTemplate has_quiet_NaN     __RW_INIT(true);            // VENDOR
    static const bool _RWSTDExportTemplate has_signaling_NaN __RW_INIT(true);            // VENDOR
    static const float_denorm_style _RWSTDExportTemplate has_denorm        __RW_INIT(denorm_indeterminate);            // VENDOR
    static const bool _RWSTDExportTemplate has_denorm_loss   __RW_INIT(false);            // VENDOR

    static long double _RWSTDExportTemplate infinity      () _RWSTD_INLINE_NO_THROW;
    static long double _RWSTDExportTemplate quiet_NaN     () _RWSTD_INLINE_NO_THROW;
    static long double _RWSTDExportTemplate signaling_NaN () _RWSTD_INLINE_NO_THROW;
    static long double _RWSTDExportTemplate denorm_min    () _RWSTD_INLINE_NO_THROW;

    static const bool _RWSTDExportTemplate is_iec559  __RW_INIT(false);                   // VENDOR
    static const bool _RWSTDExportTemplate is_bounded __RW_INIT(true);
    static const bool _RWSTDExportTemplate is_modulo  __RW_INIT(false);                   // VENDOR

    static const bool _RWSTDExportTemplate traps           __RW_INIT(false);              // VENDOR
    static const bool _RWSTDExportTemplate tinyness_before __RW_INIT(false);              // VENDOR

#ifndef _RWSTD_FLT_ROUNDS_IS_CONSTANT
    static const float_round_style _RWSTDExportTemplate round_style;
#else
    static const float_round_style _RWSTDExportTemplate round_style __RW_INIT(_RWSTD_STATIC_CAST(float_round_style,FLT_ROUNDS));
#endif
  };
#endif /* _RWSTD_NO_LONGDOUBLE */

//
// Specialization for int.
//

  _RWSTD_TEMPLATE
  class _RWSTDExport numeric_limits<int>
  {
  public:

    static const bool _RWSTDExportTemplate is_specialized __RW_INIT(true);

    static inline int min ()  _RWSTD_INLINE_NO_THROW { return INT_MIN; }
    static inline int max ()  _RWSTD_INLINE_NO_THROW { return INT_MAX; }

    static const int _RWSTDExportTemplate digits   __RW_INIT(CHAR_BIT*sizeof(int)-1);
    //    static const int _RWSTDExportTemplate digits10 __RW_INIT(int(digits/3.321928095));
    static const int _RWSTDExportTemplate digits10;

    static const bool _RWSTDExportTemplate is_signed  __RW_INIT(true);
    static const bool _RWSTDExportTemplate is_integer __RW_INIT(true);
    static const bool _RWSTDExportTemplate is_exact   __RW_INIT(true);

    static const int _RWSTDExportTemplate radix __RW_INIT(2);                             // VENDOR

    static inline int epsilon     () _RWSTD_INLINE_NO_THROW { return 0; }
    static inline int round_error () _RWSTD_INLINE_NO_THROW { return 0; }

    static const int _RWSTDExportTemplate min_exponent   __RW_INIT(0);
    static const int _RWSTDExportTemplate min_exponent10 __RW_INIT(0);
    static const int _RWSTDExportTemplate max_exponent   __RW_INIT(0);
    static const int _RWSTDExportTemplate max_exponent10 __RW_INIT(0);

    static const bool _RWSTDExportTemplate has_infinity      __RW_INIT(false);
    static const bool _RWSTDExportTemplate has_quiet_NaN     __RW_INIT(false);
    static const bool _RWSTDExportTemplate has_signaling_NaN __RW_INIT(false);
    static const float_denorm_style _RWSTDExportTemplate has_denorm        __RW_INIT(denorm_absent);
    static const bool _RWSTDExportTemplate has_denorm_loss   __RW_INIT(false);

    static inline int _RWSTDExportTemplate infinity      () _RWSTD_INLINE_NO_THROW { return 0;     }
    static inline int _RWSTDExportTemplate quiet_NaN     () _RWSTD_INLINE_NO_THROW { return 0;     }
    static inline int _RWSTDExportTemplate signaling_NaN () _RWSTD_INLINE_NO_THROW { return 0;     }
    static inline int _RWSTDExportTemplate denorm_min    () _RWSTD_INLINE_NO_THROW { return min(); }

    static const bool _RWSTDExportTemplate is_iec559  __RW_INIT(false);
    static const bool _RWSTDExportTemplate is_bounded __RW_INIT(true);
    static const bool _RWSTDExportTemplate is_modulo  __RW_INIT(false);                   // VENDOR

    static const bool _RWSTDExportTemplate traps           __RW_INIT(false);
    static const bool _RWSTDExportTemplate tinyness_before __RW_INIT(false);

    static const float_round_style _RWSTDExportTemplate round_style __RW_INIT(round_toward_zero); 
  };

#ifndef _RWSTD_NO_OVERLOAD_WCHAR

  _RWSTD_TEMPLATE
  class _RWSTDExport numeric_limits<wchar_t>
  {
  public:

    static const bool _RWSTDExportTemplate is_specialized __RW_INIT(true);

    static wchar_t min () _RWSTD_INLINE_NO_THROW;
    static wchar_t max () _RWSTD_INLINE_NO_THROW;

    static const bool _RWSTDExportTemplate is_signed  __RW_INIT(true);                    // VENDOR

    static const int _RWSTDExportTemplate digits   __RW_INIT(is_signed ? CHAR_BIT*sizeof(wchar_t) - 1 : CHAR_BIT*sizeof(wchar_t));
    //    static const int _RWSTDExportTemplate digits10 __RW_INIT(int(digits/3.321928095));
    static const int _RWSTDExportTemplate digits10;

    static const bool _RWSTDExportTemplate is_integer __RW_INIT(true);
    static const bool _RWSTDExportTemplate is_exact   __RW_INIT(true);

    static const int _RWSTDExportTemplate radix __RW_INIT(numeric_limits<int>::radix);

    static inline wchar_t epsilon     () _RWSTD_INLINE_NO_THROW { return 0; }
    static inline wchar_t round_error () _RWSTD_INLINE_NO_THROW { return 0; }

    static const int _RWSTDExportTemplate min_exponent   __RW_INIT(0);
    static const int _RWSTDExportTemplate min_exponent10 __RW_INIT(0);
    static const int _RWSTDExportTemplate max_exponent   __RW_INIT(0);
    static const int _RWSTDExportTemplate max_exponent10 __RW_INIT(0);

    static const bool _RWSTDExportTemplate has_infinity      __RW_INIT(false);
    static const bool _RWSTDExportTemplate has_quiet_NaN     __RW_INIT(false);
    static const bool _RWSTDExportTemplate has_signaling_NaN __RW_INIT(false);
    static const float_denorm_style _RWSTDExportTemplate has_denorm        __RW_INIT(denorm_absent);
    static const bool _RWSTDExportTemplate has_denorm_loss   __RW_INIT(false);

    static inline wchar_t _RWSTDExportTemplate infinity      () _RWSTD_INLINE_NO_THROW { return 0;     }
    static inline wchar_t _RWSTDExportTemplate quiet_NaN     () _RWSTD_INLINE_NO_THROW { return 0;     }
    static inline wchar_t _RWSTDExportTemplate signaling_NaN () _RWSTD_INLINE_NO_THROW { return 0;     }
    static inline wchar_t _RWSTDExportTemplate denorm_min    () _RWSTD_INLINE_NO_THROW { return min(); }

    static const bool _RWSTDExportTemplate is_iec559  __RW_INIT(false);
    static const bool _RWSTDExportTemplate is_bounded __RW_INIT(true);
    static const bool _RWSTDExportTemplate is_modulo  __RW_INIT(is_signed ? numeric_limits<int>::is_modulo : true);

    static const bool _RWSTDExportTemplate traps           __RW_INIT(false);
    static const bool _RWSTDExportTemplate tinyness_before __RW_INIT(false);

    static const float_round_style _RWSTDExportTemplate round_style __RW_INIT(round_toward_zero);
  };
#endif /*!_RWSTD_NO_OVERLOAD_WCHAR*/

//**********************************************************************
//
// There are no VENDOR-settable values beyond this point.
//
//**********************************************************************

//
// Specialization for short.
//

  _RWSTD_TEMPLATE
  class _RWSTDExport numeric_limits<short>
  {
  public:

    static const bool _RWSTDExportTemplate is_specialized __RW_INIT(true);

    static inline short min ()  _RWSTD_INLINE_NO_THROW { return SHRT_MIN; }
    static inline short max ()  _RWSTD_INLINE_NO_THROW { return SHRT_MAX; }

    static const int _RWSTDExportTemplate digits   __RW_INIT(CHAR_BIT*sizeof(short)-1);
    //    static const int _RWSTDExportTemplate digits10 __RW_INIT(int(digits/3.321928095));
    static const int _RWSTDExportTemplate digits10;

    static const bool _RWSTDExportTemplate is_signed  __RW_INIT(true);
    static const bool _RWSTDExportTemplate is_integer __RW_INIT(true);
    static const bool _RWSTDExportTemplate is_exact   __RW_INIT(true);

    static const int _RWSTDExportTemplate radix __RW_INIT(numeric_limits<int>::radix);

    static inline short epsilon     () _RWSTD_INLINE_NO_THROW { return 0; }
    static inline short round_error () _RWSTD_INLINE_NO_THROW { return 0; }

    static const int _RWSTDExportTemplate min_exponent   __RW_INIT(0);
    static const int _RWSTDExportTemplate min_exponent10 __RW_INIT(0);
    static const int _RWSTDExportTemplate max_exponent   __RW_INIT(0);
    static const int _RWSTDExportTemplate max_exponent10 __RW_INIT(0);

    static const bool _RWSTDExportTemplate has_infinity      __RW_INIT(false);
    static const bool _RWSTDExportTemplate has_quiet_NaN     __RW_INIT(false);
    static const bool _RWSTDExportTemplate has_signaling_NaN __RW_INIT(false);
    static const float_denorm_style _RWSTDExportTemplate has_denorm        __RW_INIT(denorm_absent);
    static const bool _RWSTDExportTemplate has_denorm_loss   __RW_INIT(false);
    static inline short _RWSTDExportTemplate infinity      () _RWSTD_INLINE_NO_THROW { return 0;     }
    static inline short _RWSTDExportTemplate quiet_NaN     () _RWSTD_INLINE_NO_THROW { return 0;     } 
    static inline short _RWSTDExportTemplate signaling_NaN () _RWSTD_INLINE_NO_THROW { return 0;     }
    static inline short _RWSTDExportTemplate denorm_min    () _RWSTD_INLINE_NO_THROW { return min(); }

    static const bool _RWSTDExportTemplate is_iec559  __RW_INIT(false);
    static const bool _RWSTDExportTemplate is_bounded __RW_INIT(true);
    static const bool _RWSTDExportTemplate is_modulo  __RW_INIT(numeric_limits<int>::is_modulo);

    static const bool _RWSTDExportTemplate traps           __RW_INIT(false);
    static const bool _RWSTDExportTemplate tinyness_before __RW_INIT(false);

    static const float_round_style _RWSTDExportTemplate round_style __RW_INIT(round_toward_zero);
  };

//
// Specialization for unsigned short.
//

  _RWSTD_TEMPLATE
  class _RWSTDExport numeric_limits<unsigned short>
  {
  public:

    static const bool _RWSTDExportTemplate is_specialized __RW_INIT(true);

    static inline unsigned short min ()  _RWSTD_INLINE_NO_THROW { return 0;         }
    static inline unsigned short max ()  _RWSTD_INLINE_NO_THROW { return USHRT_MAX; }

    static const int _RWSTDExportTemplate digits   __RW_INIT(CHAR_BIT*sizeof(unsigned short));
    //    static const int _RWSTDExportTemplate digits10 __RW_INIT(int(digits/3.321928095));
    static const int _RWSTDExportTemplate digits10;

    static const bool _RWSTDExportTemplate is_signed  __RW_INIT(false);
    static const bool _RWSTDExportTemplate is_integer __RW_INIT(true);
    static const bool _RWSTDExportTemplate is_exact   __RW_INIT(true);

    static const int _RWSTDExportTemplate radix __RW_INIT(numeric_limits<int>::radix);

    static inline unsigned short epsilon     () _RWSTD_INLINE_NO_THROW { return 0; }
    static inline unsigned short round_error () _RWSTD_INLINE_NO_THROW { return 0; }

    static const int _RWSTDExportTemplate min_exponent   __RW_INIT(0);
    static const int _RWSTDExportTemplate min_exponent10 __RW_INIT(0);
    static const int _RWSTDExportTemplate max_exponent   __RW_INIT(0);
    static const int _RWSTDExportTemplate max_exponent10 __RW_INIT(0);

    static const bool _RWSTDExportTemplate has_infinity      __RW_INIT(false);
    static const bool _RWSTDExportTemplate has_quiet_NaN     __RW_INIT(false);
    static const bool _RWSTDExportTemplate has_signaling_NaN __RW_INIT(false);
    static const float_denorm_style _RWSTDExportTemplate has_denorm        __RW_INIT(denorm_absent);
    static const bool _RWSTDExportTemplate has_denorm_loss   __RW_INIT(false);

    static inline unsigned short infinity      () _RWSTD_INLINE_NO_THROW { return 0;     }
    static inline unsigned short quiet_NaN     () _RWSTD_INLINE_NO_THROW { return 0;     }
    static inline unsigned short signaling_NaN () _RWSTD_INLINE_NO_THROW { return 0;     }
    static inline unsigned short denorm_min    () _RWSTD_INLINE_NO_THROW { return min(); }

    static const bool _RWSTDExportTemplate is_iec559  __RW_INIT(false);
    static const bool _RWSTDExportTemplate is_bounded __RW_INIT(true);
    static const bool _RWSTDExportTemplate is_modulo  __RW_INIT(true);

    static const bool _RWSTDExportTemplate traps           __RW_INIT(false);
    static const bool _RWSTDExportTemplate tinyness_before __RW_INIT(false);

    static const float_round_style _RWSTDExportTemplate round_style __RW_INIT(round_toward_zero);
  };

//
// Specialization for unsigned int.
//

  _RWSTD_TEMPLATE
  class _RWSTDExport numeric_limits<unsigned int>
  {
  public:

    static const bool _RWSTDExportTemplate is_specialized __RW_INIT(true);

    static inline unsigned int min ()  _RWSTD_INLINE_NO_THROW { return 0;        }
    static inline unsigned int max ()  _RWSTD_INLINE_NO_THROW { return UINT_MAX; }

    static const int _RWSTDExportTemplate digits   __RW_INIT(CHAR_BIT*sizeof(unsigned int));
    //    static const int _RWSTDExportTemplate digits10 __RW_INIT(int(digits/3.321928095));
    static const int _RWSTDExportTemplate digits10;

    static const bool _RWSTDExportTemplate is_signed  __RW_INIT(false);
    static const bool _RWSTDExportTemplate is_integer __RW_INIT(true);
    static const bool _RWSTDExportTemplate is_exact   __RW_INIT(true);

    static const int _RWSTDExportTemplate radix __RW_INIT(numeric_limits<int>::radix);

    static inline unsigned int epsilon     () _RWSTD_INLINE_NO_THROW { return 0; }
    static inline unsigned int round_error () _RWSTD_INLINE_NO_THROW { return 0; }

    static const int _RWSTDExportTemplate min_exponent   __RW_INIT(0);
    static const int _RWSTDExportTemplate min_exponent10 __RW_INIT(0);
    static const int _RWSTDExportTemplate max_exponent   __RW_INIT(0);
    static const int _RWSTDExportTemplate max_exponent10 __RW_INIT(0);

    static const bool _RWSTDExportTemplate has_infinity      __RW_INIT(false);
    static const bool _RWSTDExportTemplate has_quiet_NaN     __RW_INIT(false);
    static const bool _RWSTDExportTemplate has_signaling_NaN __RW_INIT(false);
    static const float_denorm_style _RWSTDExportTemplate has_denorm        __RW_INIT(denorm_absent);
    static const bool _RWSTDExportTemplate has_denorm_loss   __RW_INIT(false);

    static inline unsigned int infinity      () _RWSTD_INLINE_NO_THROW { return 0;     }
    static inline unsigned int quiet_NaN     () _RWSTD_INLINE_NO_THROW { return 0;     }
    static inline unsigned int signaling_NaN () _RWSTD_INLINE_NO_THROW { return 0;     }
    static inline unsigned int denorm_min    () _RWSTD_INLINE_NO_THROW { return min(); }

    static const bool _RWSTDExportTemplate is_iec559  __RW_INIT(false);
    static const bool _RWSTDExportTemplate is_bounded __RW_INIT(true);
    static const bool _RWSTDExportTemplate is_modulo  __RW_INIT(true);

    static const bool _RWSTDExportTemplate traps           __RW_INIT(false);
    static const bool _RWSTDExportTemplate tinyness_before __RW_INIT(false);

    static const float_round_style _RWSTDExportTemplate round_style __RW_INIT(round_toward_zero);
  };

//
// Specialization for long.
//

  _RWSTD_TEMPLATE
  class _RWSTDExport numeric_limits<long>
  {
  public:

    static const bool _RWSTDExportTemplate is_specialized __RW_INIT(true);

    static inline long min ()  _RWSTD_INLINE_NO_THROW { return LONG_MIN; }
    static inline long max ()  _RWSTD_INLINE_NO_THROW { return LONG_MAX; }

    static const int _RWSTDExportTemplate digits   __RW_INIT(CHAR_BIT*sizeof(long)-1);
    //    static const int _RWSTDExportTemplate digits10 __RW_INIT(int(digits/3.321928095));
    static const int _RWSTDExportTemplate digits10;

    static const bool _RWSTDExportTemplate is_signed  __RW_INIT(true);
    static const bool _RWSTDExportTemplate is_integer __RW_INIT(true);
    static const bool _RWSTDExportTemplate is_exact   __RW_INIT(true);

    static const int _RWSTDExportTemplate radix __RW_INIT(numeric_limits<int>::radix);

    static inline long epsilon     () _RWSTD_INLINE_NO_THROW { return 0; }
    static inline long round_error () _RWSTD_INLINE_NO_THROW { return 0; }

    static const int _RWSTDExportTemplate min_exponent   __RW_INIT(0);
    static const int _RWSTDExportTemplate min_exponent10 __RW_INIT(0); 
    static const int _RWSTDExportTemplate max_exponent   __RW_INIT(0);
    static const int _RWSTDExportTemplate max_exponent10 __RW_INIT(0);

    static const bool _RWSTDExportTemplate has_infinity      __RW_INIT(false);
    static const bool _RWSTDExportTemplate has_quiet_NaN     __RW_INIT(false);
    static const bool _RWSTDExportTemplate has_signaling_NaN __RW_INIT(false);
    static const float_denorm_style _RWSTDExportTemplate has_denorm        __RW_INIT(denorm_absent);
    static const bool _RWSTDExportTemplate has_denorm_loss   __RW_INIT(false);

    static inline long infinity      () _RWSTD_INLINE_NO_THROW { return 0;     }
    static inline long quiet_NaN     () _RWSTD_INLINE_NO_THROW { return 0;     }
    static inline long signaling_NaN () _RWSTD_INLINE_NO_THROW { return 0;     }
    static inline long denorm_min    () _RWSTD_INLINE_NO_THROW { return min(); }

    static const bool _RWSTDExportTemplate is_iec559  __RW_INIT(false);
    static const bool _RWSTDExportTemplate is_bounded __RW_INIT(true);
    static const bool _RWSTDExportTemplate is_modulo  __RW_INIT(numeric_limits<int>::is_modulo);

    static const bool _RWSTDExportTemplate traps           __RW_INIT(false);
    static const bool _RWSTDExportTemplate tinyness_before __RW_INIT(false);

    static const float_round_style _RWSTDExportTemplate round_style __RW_INIT(round_toward_zero);
  };

//
// Specialization for unsigned long.
//

  _RWSTD_TEMPLATE
  class _RWSTDExport numeric_limits<unsigned long>
  {
  public:

    static const bool _RWSTDExportTemplate is_specialized __RW_INIT(true);

    static inline unsigned long min ()  _RWSTD_INLINE_NO_THROW { return 0;         }
    static inline unsigned long max ()  _RWSTD_INLINE_NO_THROW { return ULONG_MAX; }

    static const int _RWSTDExportTemplate digits   __RW_INIT(CHAR_BIT*sizeof(unsigned long));
    //    static const int _RWSTDExportTemplate digits10 __RW_INIT(int(digits/3.321928095));
    static const int _RWSTDExportTemplate digits10;

    static const bool _RWSTDExportTemplate is_signed  __RW_INIT(false);
    static const bool _RWSTDExportTemplate is_integer __RW_INIT(true);
    static const bool _RWSTDExportTemplate is_exact   __RW_INIT(true);

    static const int _RWSTDExportTemplate radix __RW_INIT(numeric_limits<int>::radix);

    static inline unsigned long epsilon     () _RWSTD_INLINE_NO_THROW { return 0; }
    static inline unsigned long round_error () _RWSTD_INLINE_NO_THROW { return 0; }

    static const int _RWSTDExportTemplate min_exponent   __RW_INIT(0);
    static const int _RWSTDExportTemplate min_exponent10 __RW_INIT(0); 
    static const int _RWSTDExportTemplate max_exponent   __RW_INIT(0);
    static const int _RWSTDExportTemplate max_exponent10 __RW_INIT(0);

    static const bool _RWSTDExportTemplate has_infinity      __RW_INIT(false);
    static const bool _RWSTDExportTemplate has_quiet_NaN     __RW_INIT(false);
    static const bool _RWSTDExportTemplate has_signaling_NaN __RW_INIT(false);
    static const float_denorm_style _RWSTDExportTemplate has_denorm        __RW_INIT(denorm_absent);
    static const bool _RWSTDExportTemplate has_denorm_loss   __RW_INIT(false);

    static inline unsigned long infinity      () _RWSTD_INLINE_NO_THROW { return 0;     }
    static inline unsigned long quiet_NaN     () _RWSTD_INLINE_NO_THROW { return 0;     }
    static inline unsigned long signaling_NaN () _RWSTD_INLINE_NO_THROW { return 0;     }
    static inline unsigned long denorm_min    () _RWSTD_INLINE_NO_THROW { return min(); }

    static const bool _RWSTDExportTemplate is_iec559  __RW_INIT(false);
    static const bool _RWSTDExportTemplate is_bounded __RW_INIT(true);
    static const bool _RWSTDExportTemplate is_modulo  __RW_INIT(true);

    static const bool _RWSTDExportTemplate traps           __RW_INIT(false);
    static const bool _RWSTDExportTemplate tinyness_before __RW_INIT(false);

    static const float_round_style _RWSTDExportTemplate round_style __RW_INIT(round_toward_zero);
  };

//
// Specialization for char.
//

  _RWSTD_TEMPLATE
  class _RWSTDExport numeric_limits<char>
  {
  public:

    static const bool _RWSTDExportTemplate is_specialized __RW_INIT(true);

    static inline char min ()  _RWSTD_INLINE_NO_THROW { return CHAR_MIN; }
    static inline char max ()  _RWSTD_INLINE_NO_THROW { return CHAR_MAX; }

    static const bool _RWSTDExportTemplate is_signed  __RW_INIT(CHAR_MAX == SCHAR_MAX ? true : false);

    static const int _RWSTDExportTemplate digits   __RW_INIT(is_signed ? CHAR_BIT*sizeof(char) -1 : CHAR_BIT*sizeof(char));
    //    static const int _RWSTDExportTemplate digits10 __RW_INIT(int(digits/3.321928095));
    static const int _RWSTDExportTemplate digits10;

    static const bool _RWSTDExportTemplate is_integer __RW_INIT(true);
    static const bool _RWSTDExportTemplate is_exact   __RW_INIT(true);

    static const int _RWSTDExportTemplate radix __RW_INIT(numeric_limits<int>::radix);

    static inline char epsilon     () _RWSTD_INLINE_NO_THROW { return 0; }
    static inline char round_error () _RWSTD_INLINE_NO_THROW { return 0; }

    static const int _RWSTDExportTemplate min_exponent   __RW_INIT(0);
    static const int _RWSTDExportTemplate min_exponent10 __RW_INIT(0); 
    static const int _RWSTDExportTemplate max_exponent   __RW_INIT(0);
    static const int _RWSTDExportTemplate max_exponent10 __RW_INIT(0);

    static const bool _RWSTDExportTemplate has_infinity      __RW_INIT(false);
    static const bool _RWSTDExportTemplate has_quiet_NaN     __RW_INIT(false);
    static const bool _RWSTDExportTemplate has_signaling_NaN __RW_INIT(false);
    static const float_denorm_style _RWSTDExportTemplate has_denorm        __RW_INIT(denorm_absent);
    static const bool _RWSTDExportTemplate has_denorm_loss   __RW_INIT(false);

    static inline char infinity      () _RWSTD_INLINE_NO_THROW { return 0;     }
    static inline char quiet_NaN     () _RWSTD_INLINE_NO_THROW { return 0;     }
    static inline char signaling_NaN () _RWSTD_INLINE_NO_THROW { return 0;     }
    static inline char denorm_min    () _RWSTD_INLINE_NO_THROW { return min(); }
    
    static const bool _RWSTDExportTemplate is_iec559  __RW_INIT(false);
    static const bool _RWSTDExportTemplate is_bounded __RW_INIT(true);
    static const bool _RWSTDExportTemplate is_modulo  __RW_INIT(is_signed ? numeric_limits<int>::is_modulo : true);

    static const bool _RWSTDExportTemplate traps           __RW_INIT(false);
    static const bool _RWSTDExportTemplate tinyness_before __RW_INIT(false);

    static const float_round_style _RWSTDExportTemplate round_style __RW_INIT(round_toward_zero);
  };

//
// Specialization for unsigned char.
//

  _RWSTD_TEMPLATE
  class _RWSTDExport numeric_limits<unsigned char>
  {
  public:

    static const bool _RWSTDExportTemplate is_specialized __RW_INIT(true);

    static inline unsigned char min ()  _RWSTD_INLINE_NO_THROW { return 0;         }
    static inline unsigned char max ()  _RWSTD_INLINE_NO_THROW { return UCHAR_MAX; }

    static const int _RWSTDExportTemplate digits   __RW_INIT(CHAR_BIT*sizeof(unsigned char));
    //    static const int _RWSTDExportTemplate digits10 __RW_INIT(int(digits/3.321928095)); 
    static const int _RWSTDExportTemplate digits10;

    static const bool _RWSTDExportTemplate is_signed  __RW_INIT(false);
    static const bool _RWSTDExportTemplate is_integer __RW_INIT(true);
    static const bool _RWSTDExportTemplate is_exact   __RW_INIT(true);

    static const int _RWSTDExportTemplate radix __RW_INIT(numeric_limits<int>::radix);

    static inline unsigned char epsilon     () _RWSTD_INLINE_NO_THROW { return 0; }
    static inline unsigned char round_error () _RWSTD_INLINE_NO_THROW { return 0; }

    static const int _RWSTDExportTemplate min_exponent   __RW_INIT(0);
    static const int _RWSTDExportTemplate min_exponent10 __RW_INIT(0); 
    static const int _RWSTDExportTemplate max_exponent   __RW_INIT(0);
    static const int _RWSTDExportTemplate max_exponent10 __RW_INIT(0);

    static const bool _RWSTDExportTemplate has_infinity      __RW_INIT(false);
    static const bool _RWSTDExportTemplate has_quiet_NaN     __RW_INIT(false);
    static const bool _RWSTDExportTemplate has_signaling_NaN __RW_INIT(false);
    static const float_denorm_style _RWSTDExportTemplate has_denorm        __RW_INIT(denorm_absent);
    static const bool _RWSTDExportTemplate has_denorm_loss   __RW_INIT(false);

    static inline unsigned char infinity      () _RWSTD_INLINE_NO_THROW { return 0;     }
    static inline unsigned char quiet_NaN     () _RWSTD_INLINE_NO_THROW { return 0;     }
    static inline unsigned char signaling_NaN () _RWSTD_INLINE_NO_THROW { return 0;     }
    static inline unsigned char denorm_min    () _RWSTD_INLINE_NO_THROW { return min(); }

    static const bool _RWSTDExportTemplate is_iec559  __RW_INIT(false);
    static const bool _RWSTDExportTemplate is_bounded __RW_INIT(true);
    static const bool _RWSTDExportTemplate is_modulo  __RW_INIT(true);

    static const bool _RWSTDExportTemplate traps           __RW_INIT(false);
    static const bool _RWSTDExportTemplate tinyness_before __RW_INIT(false);

    static const float_round_style _RWSTDExportTemplate round_style __RW_INIT(round_toward_zero);
  };

//
// Specialization for signed char.
//

  _RWSTD_TEMPLATE
  class _RWSTDExport numeric_limits<signed char>
  {
  public:

    static const bool _RWSTDExportTemplate is_specialized __RW_INIT(true);

    static inline signed char min ()  _RWSTD_INLINE_NO_THROW { return SCHAR_MIN; }
    static inline signed char max ()  _RWSTD_INLINE_NO_THROW { return SCHAR_MAX; }

    static const _RWSTDExportTemplate int digits   __RW_INIT(CHAR_BIT*sizeof(signed char)-1);
    //    static const _RWSTDExportTemplate int digits10 __RW_INIT(int(digits/3.321928095));
    static const _RWSTDExportTemplate int digits10;

    static const bool _RWSTDExportTemplate is_signed  __RW_INIT(true);
    static const bool _RWSTDExportTemplate is_integer __RW_INIT(true);
    static const bool _RWSTDExportTemplate is_exact   __RW_INIT(true);

    static const int _RWSTDExportTemplate radix __RW_INIT(numeric_limits<int>::radix);

    static inline signed char epsilon     () _RWSTD_INLINE_NO_THROW { return 0; }
    static inline signed char round_error () _RWSTD_INLINE_NO_THROW { return 0; }

    static const int _RWSTDExportTemplate min_exponent   __RW_INIT(0);
    static const int _RWSTDExportTemplate min_exponent10 __RW_INIT(0); 
    static const int _RWSTDExportTemplate max_exponent   __RW_INIT(0);
    static const int _RWSTDExportTemplate max_exponent10 __RW_INIT(0);

    static const bool _RWSTDExportTemplate has_infinity      __RW_INIT(false);
    static const bool _RWSTDExportTemplate has_quiet_NaN     __RW_INIT(false);
    static const bool _RWSTDExportTemplate has_signaling_NaN __RW_INIT(false);
    static const float_denorm_style _RWSTDExportTemplate has_denorm        __RW_INIT(denorm_absent);
    static const bool _RWSTDExportTemplate has_denorm_loss   __RW_INIT(false);

    static inline signed char infinity      () _RWSTD_INLINE_NO_THROW { return 0;     }
    static inline signed char quiet_NaN     () _RWSTD_INLINE_NO_THROW { return 0;     }
    static inline signed char signaling_NaN () _RWSTD_INLINE_NO_THROW { return 0;     }
    static inline signed char denorm_min    () _RWSTD_INLINE_NO_THROW { return min(); }

    static const bool _RWSTDExportTemplate is_iec559  __RW_INIT(false);
    static const bool _RWSTDExportTemplate is_bounded __RW_INIT(true);
    static const bool _RWSTDExportTemplate is_modulo  __RW_INIT(numeric_limits<int>::is_modulo);

    static const bool _RWSTDExportTemplate traps           __RW_INIT(false);
    static const bool _RWSTDExportTemplate tinyness_before __RW_INIT(false);

    static const float_round_style _RWSTDExportTemplate round_style __RW_INIT(round_toward_zero);
  };

#ifndef _RWSTD_NO_BOOL
//
// Specialization for bool.
//

  _RWSTD_TEMPLATE
  class _RWSTDExport numeric_limits<bool>
  {
  public:

    static const bool _RWSTDExportTemplate is_specialized __RW_INIT(true);

    static inline bool min ()  _RWSTD_INLINE_NO_THROW { return false; }
    static inline bool max ()  _RWSTD_INLINE_NO_THROW { return true;  }

    static const _RWSTDExportTemplate int digits   __RW_INIT(1);
    static const _RWSTDExportTemplate int digits10 __RW_INIT(0);

    static const bool _RWSTDExportTemplate is_signed  __RW_INIT(false);
    static const bool _RWSTDExportTemplate is_integer __RW_INIT(true);
    static const bool _RWSTDExportTemplate is_exact   __RW_INIT(true);

    static const int _RWSTDExportTemplate radix __RW_INIT(numeric_limits<int>::radix);

    static inline bool epsilon     () _RWSTD_INLINE_NO_THROW { return 0; }
    static inline bool round_error () _RWSTD_INLINE_NO_THROW { return 0; }

    static const int _RWSTDExportTemplate min_exponent   __RW_INIT(0);
    static const int _RWSTDExportTemplate min_exponent10 __RW_INIT(0); 
    static const int _RWSTDExportTemplate max_exponent   __RW_INIT(0);
    static const int _RWSTDExportTemplate max_exponent10 __RW_INIT(0);

    static const bool _RWSTDExportTemplate has_infinity      __RW_INIT(false);
    static const bool _RWSTDExportTemplate has_quiet_NaN     __RW_INIT(false);
    static const bool _RWSTDExportTemplate has_signaling_NaN __RW_INIT(false);
    static const float_denorm_style _RWSTDExportTemplate has_denorm        __RW_INIT(denorm_absent);
    static const bool _RWSTDExportTemplate has_denorm_loss   __RW_INIT(false);

    static inline int infinity      () _RWSTD_INLINE_NO_THROW { return 0;     }
    static inline int quiet_NaN     () _RWSTD_INLINE_NO_THROW { return 0;     }
    static inline int signaling_NaN () _RWSTD_INLINE_NO_THROW { return 0;     }
    static inline int denorm_min    () _RWSTD_INLINE_NO_THROW { return min(); }

    static const bool _RWSTDExportTemplate is_iec559  __RW_INIT(false);
    static const bool _RWSTDExportTemplate is_bounded __RW_INIT(true);
    static const bool _RWSTDExportTemplate is_modulo  __RW_INIT(false);

    static const bool _RWSTDExportTemplate traps           __RW_INIT(false);
    static const bool _RWSTDExportTemplate tinyness_before __RW_INIT(false);

    static const float_round_style _RWSTDExportTemplate round_style __RW_INIT(round_toward_zero);
  };
#endif /*!_RWSTD_NO_BOOL*/

  template <class T>
  class _RWSTDExportTemplate numeric_limits
  {
  public:

    static const bool is_specialized;

    static inline T min () _RWSTD_INLINE_NO_THROW { return _RWSTD_STATIC_CAST(T,0); }
    static inline T max () _RWSTD_INLINE_NO_THROW { return _RWSTD_STATIC_CAST(T,0); }

    static const int digits;
    static const int digits10;
    
    static const bool is_signed;
    static const bool is_integer;
    static const bool is_exact;

    static const int radix;
    static inline T  epsilon     () _RWSTD_INLINE_NO_THROW { return _RWSTD_STATIC_CAST(T,0); }
    static inline T  round_error () _RWSTD_INLINE_NO_THROW { return _RWSTD_STATIC_CAST(T,0); }

    static const int min_exponent;
    static const int min_exponent10; 
    static const int max_exponent;
    static const int max_exponent10;

    static const bool has_infinity;
    static const bool has_quiet_NaN;
    static const bool has_signaling_NaN;
    static const float_denorm_style has_denorm;
    static const bool has_denorm_loss;

    static inline T infinity      () _RWSTD_INLINE_NO_THROW { return _RWSTD_STATIC_CAST(T,0); }
    static inline T quiet_NaN     () _RWSTD_INLINE_NO_THROW { return _RWSTD_STATIC_CAST(T,0); }
    static inline T signaling_NaN () _RWSTD_INLINE_NO_THROW { return _RWSTD_STATIC_CAST(T,0); }

    static inline T denorm_min    () _RWSTD_INLINE_NO_THROW { return min(); }

    static const bool is_iec559;
    static const bool is_bounded;
    static const bool is_modulo;

    static const bool traps;
    static const bool tinyness_before;

    static const float_round_style round_style;
  };

#ifndef _RWSTD_NO_TEMPLATE_SPECIALIZATION  
  template <class T>
  const bool numeric_limits<T>::is_specialized = false;

  template <class T>
  const int numeric_limits<T>::digits = 0;

  template <class T>
  const int numeric_limits<T>::digits10 = 0;

  template <class T>
  const bool numeric_limits<T>::is_signed = false;

  template <class T>
  const bool numeric_limits<T>::is_integer = false;

  template <class T>
  const bool numeric_limits<T>::is_exact = false;

  template <class T>
  const int numeric_limits<T>::radix = 0;

  template <class T>
  const int numeric_limits<T>::min_exponent10 =0; 

  template <class T>
  const int numeric_limits<T>::max_exponent10 = 0;

  template <class T>
  const int numeric_limits<T>::min_exponent = 0;

  template <class T>
  const int numeric_limits<T>::max_exponent = 0;

  template <class T>
  const bool numeric_limits<T>::has_infinity = false;

  template <class T>
  const bool numeric_limits<T>::has_quiet_NaN = false;

  template <class T>
  const bool numeric_limits<T>::has_signaling_NaN = false;    

  template <class T>
  const bool numeric_limits<T>::is_iec559 = false;

  template <class T>
  const bool numeric_limits<T>::is_bounded = false;

  template <class T>
  const bool numeric_limits<T>::is_modulo = false;

  template <class T>
  const float_denorm_style numeric_limits<T>::has_denorm = denorm_absent;
 
  template <class T>
  const bool numeric_limits<T>::has_denorm_loss = false;

  template <class T>
  const bool numeric_limits<T>::traps = false;

  template <class T>
  const bool numeric_limits<T>::tinyness_before = false;

  template <class T>
  const float_round_style numeric_limits<T>::round_style = round_toward_zero;
#endif

#undef __RW_INIT

#ifndef _RWSTD_NO_NAMESPACE 
} 

#endif

#endif /*__STD_LIMITS*/
#pragma option pop
#endif /* __LIMITS_CC */
