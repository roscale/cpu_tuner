use std::io;
use std::process::{Command, Child};

use x86::cpuid::VendorInfo;
use x86::msr::MSR_PKG_POWER_LIMIT;

use crate::bitfields::TurboRatioLimitsBitfield;
use crate::structures::TurboRatioLimits;
use crate::util::byte_slice_to_u64;

pub mod util;
pub mod structures;

pub mod ffi;
pub mod bitfields;

fn rdmsr(register: u32) -> Result<u64, io::Error> {
    Command::new("rdmsr")
        .arg("-r")
        .arg(format!("0x{:x}", register))
        .output()
        .and_then(|output| {
            if !output.status.success() {
                return Result::Err(io::Error::new(io::ErrorKind::Other, String::from_utf8(output.stderr).unwrap()));
            }
            Ok(byte_slice_to_u64(&output.stdout))
        })
}

fn wrmsr(register: u32, value: u64) {
    dbg!(register, value);
    Command::new("wrmsr")
        .arg(format!("0x{:x}", register))
        .arg(format!("0x{:x}", value))
        .spawn();
}

#[cfg(target_os = "linux")]
fn get_sensors() -> io::Result<String> {
    Command::new("sensors")
        .arg("-j")
        .output()
        .and_then(|output| {
            String::from_utf8(output.stdout)
                .map_err(|err| io::Error::new(io::ErrorKind::InvalidData, err))
        })
}

fn get_vendor() -> Option<VendorInfo> {
    let cpuid = x86::cpuid::CpuId::new();
    cpuid.get_vendor_info()
}

fn get_turbo_ratio_limits() -> io::Result<TurboRatioLimits> {
    let bitfield = rdmsr(x86::msr::MSR_TURBO_RATIO_LIMIT)?;
    let bitfield = TurboRatioLimitsBitfield(bitfield);
    Ok(TurboRatioLimits {
        ratio_1_cores_active: bitfield.ratio_1_active_cores() as u8,
        ratio_2_cores_active: bitfield.ratio_2_active_cores() as u8,
        ratio_3_cores_active: bitfield.ratio_3_active_cores() as u8,
        ratio_4_cores_active: bitfield.ratio_4_active_cores() as u8,
    })
}

fn set_turbo_ratio_limits(turbo_ratio_limits: &TurboRatioLimits) {
    let mut bitfield = TurboRatioLimitsBitfield(0);
    bitfield.set_ratio_1_active_cores(turbo_ratio_limits.ratio_1_cores_active as u64);
    bitfield.set_ratio_2_active_cores(turbo_ratio_limits.ratio_2_cores_active as u64);
    bitfield.set_ratio_3_active_cores(turbo_ratio_limits.ratio_3_cores_active as u64);
    bitfield.set_ratio_4_active_cores(turbo_ratio_limits.ratio_4_cores_active as u64);
    wrmsr(x86::msr::MSR_TURBO_RATIO_LIMIT, bitfield.0);
}
