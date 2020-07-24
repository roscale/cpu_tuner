#[inline]
fn convert_power_unit(unit: u64) -> f64 {
    0.5f64.powf(unit as f64)
}

pub fn byte_slice_to_u64(slice: &[u8]) -> u64 {
    slice.iter().rev().fold(0, |x, &i| x << 8 | i as u64)
}

pub trait ToPtr {
    fn into_ptr(self) -> *mut Self;
}

impl<T> ToPtr for T {
    fn into_ptr(self) -> *mut Self {
        Box::into_raw(Box::new(self))
    }
}


