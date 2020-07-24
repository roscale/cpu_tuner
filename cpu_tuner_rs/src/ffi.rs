use std::error::Error;
use std::ffi::{CStr, CString};
use std::os::raw::{c_char, c_void};
use std::ptr::null_mut;

use crate::{get_turbo_ratio_limits, set_turbo_ratio_limits};
use crate::structures::TurboRatioLimits;
use crate::util::ToPtr;
use std::borrow::Borrow;

#[repr(C)]
pub struct Result {
    pub ok: *mut c_void,
    pub err: *mut c_char,
}

#[no_mangle]
pub extern fn ffi_get_turbo_ratio_limits() -> *mut Result {
    match get_turbo_ratio_limits() {
        Ok(turbo_ratio_limits) => {
            Result {
                ok: turbo_ratio_limits.into_ptr() as *mut c_void,
                err: null_mut(),
            }.into_ptr()
        }
        Err(err) => {
            Result {
                ok: null_mut(),
                err: CString::new(err.to_string()).unwrap().into_raw(),
            }.into_ptr()
        }
    }
}

#[no_mangle]
pub unsafe extern fn ffi_set_turbo_ratio_limits(ptr: *mut TurboRatioLimits) {
    assert!(!ptr.is_null());
    set_turbo_ratio_limits(ptr.as_ref().unwrap());
}
