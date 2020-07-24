bitfield::bitfield! {
      pub struct PkgPowerLimitsBitfield(u64);
      impl Debug;
      pub power_limit, set_power_limit: 14, 0;
      pub power_enabled, set_power_enabled: 15;
      pub clamping_limit, set_clamping_limit: 16;
      pub power_limit_time_window, set_power_limit_time_window: 23, 17;

      pub power_limit2, set_power_limit2: 46, 32;
      pub power_enabled2, set_power_enabled2: 47;
      pub clamping_limit2, set_clamping_limit2: 48;
      pub power_limit_time_window2, set_power_limit_time_window2: 55, 49;

      pub msr_lock, set_msr_lock: 63;
}

bitfield::bitfield! {
    pub struct RAPLPowerUnitBitfield(u64);
    impl Debug;
    pub power_unit, _: 3, 0;
    pub energy_unit, _: 12, 8;
    pub time_unit, _: 19, 16;
}

bitfield::bitfield! {
    pub struct TurboRatioLimitsBitfield(u64);
    impl Debug;
    pub ratio_1_active_cores, set_ratio_1_active_cores: 7, 0;
    pub ratio_2_active_cores, set_ratio_2_active_cores: 15, 8;
    pub ratio_3_active_cores, set_ratio_3_active_cores: 23, 16;
    pub ratio_4_active_cores, set_ratio_4_active_cores: 31, 24;
}
