use std::io::{Error, ErrorKind};
use std::process::Command;

use x86::msr::MSR_PKG_POWER_LIMIT;
use cpu_tuner::ffi::{ffi_get_turbo_ratio_limits, ffi_set_turbo_ratio_limits};
use cpu_tuner::structures::TurboRatioLimits;
use std::ffi::CStr;
use cpu_tuner::util::ToPtr;

fn main() {
    // unsafe {
    //     let result = ffi_get_turbo_ratio_limits();
    //     let err = result.read().err;
    //     let ok = result.read().ok;
    //
    //     if !err.is_null() {
    //         dbg!(CStr::from_ptr(err));
    //     } else {
    //         dbg!(ok.cast::<TurboRatioLimits>().read());
    //     }
    // }

    unsafe {
        ffi_set_turbo_ratio_limits(TurboRatioLimits {
            ratio_1_cores_active: 1,
            ratio_2_cores_active: 2,
            ratio_3_cores_active: 3,
            ratio_4_cores_active: 4
        }.into_ptr())
    }

    // match rdmsr(x86::msr::MSR_RAPL_POWER_UNIT) {
    //     Ok(value) => {
    //         let power_unit = RAPLPowerUnit(value);
    //         let power_unit_in_watts = convert_power_unit(power_unit.power_unit());
    //         dbg!(power_unit_in_watts);
    //         dbg!(convert_power_unit(power_unit.energy_unit()));
    //         dbg!(convert_power_unit(power_unit.time_unit()));
    //
    //         match rdmsr(x86::msr::MSR_PKG_POWER_LIMIT) {
    //             Ok(value) => {
    //                 let pkg_power_limit = PkgPowerLimit(value);
    //                 let pkg_power_limit_in_watts = power_unit_in_watts * pkg_power_limit.power_limit() as f64;
    //                 dbg!(pkg_power_limit_in_watts);
    //             }
    //             Err(err) => eprintln!("{}", err)
    //         }
    //     }
    //     Err(err) => eprintln!("{}", err)
    // }
}