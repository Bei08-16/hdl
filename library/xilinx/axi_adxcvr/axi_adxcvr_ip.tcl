## AUTO GENERATED BY axi_adxcvr.pl, DO NOT MODIFY!


source ../scripts/adi_ip_xilinx.tcl

adi_ip_create axi_adxcvr
adi_ip_files axi_adxcvr [list \
  "$ad_hdl_dir/library/common/up_axi.v" \
  "$ad_hdl_dir/library/scripts/adi_xilinx_device_info_enc.tcl" \
  "axi_adxcvr_es.v" \
  "axi_adxcvr_up.v" \
  "axi_adxcvr_mdrp.v" \
  "axi_adxcvr_mstatus.v" \
  "axi_adxcvr.v" ]

adi_ip_properties axi_adxcvr
adi_ip_infer_mm_interfaces axi_adxcvr

adi_init_bd_tcl
adi_ip_bd axi_adxcvr "bd/bd.tcl"

set_property company_url {https://wiki.analog.com/resources/fpga/docs/axi_adxcvr} [ipx::current_core]

set cc [ipx::current_core]

# Arrange GUI page layout
set page0 [ipgui::get_pagespec -name "Page 0" -component $cc]
# Link layer mode
set p [ipgui::get_guiparamspec -name "LINK_MODE" -component $cc]
ipgui::move_param -component $cc -order 0 $p -parent $page0
set_property -dict [list \
 "display_name" "Link Layer mode" \
 "tooltip" "Link Layer mode" \
 "widget" "comboBox" \
] $p

set_property -dict [list \
  value_validation_type pairs \
  value_validation_pairs {64B66B 2 8B10B 1} \
] [ipx::get_user_parameters $p -of_objects $cc]

set_property driver_value 0 [ipx::get_ports -filter "direction==in" -of_objects [ipx::current_core]]

set_property master_address_space_ref m_axi \
    [ipx::get_bus_interfaces m_axi \
    -of_objects [ipx::current_core]]

for {set n 0} {$n < 32} {incr n} {

  if {($n%4) == 0} {
  adi_if_infer_bus analog.com:interface:if_xcvr_cm master up_cm_${n} [list \
    "enb                 up_cm_enb_${n}         "\
    "addr                up_cm_addr_${n}        "\
    "wr                  up_cm_wr_${n}          "\
    "wdata               up_cm_wdata_${n}       "\
    "rdata               up_cm_rdata_${n}       "\
    "ready               up_cm_ready_${n}       "]
  }

  adi_if_infer_bus analog.com:interface:if_xcvr_cm master up_es_${n} [list \
    "enb                 up_es_enb_${n}         "\
    "addr                up_es_addr_${n}        "\
    "wr                  up_es_wr_${n}          "\
    "reset               up_es_reset_${n}       "\
    "wdata               up_es_wdata_${n}       "\
    "rdata               up_es_rdata_${n}       "\
    "ready               up_es_ready_${n}       "]

  adi_if_infer_bus analog.com:interface:if_xcvr_ch master up_ch_${n} [list \
    "pll_locked          up_ch_pll_locked_${n}  "\
    "rst                 up_ch_rst_${n}         "\
    "user_ready          up_ch_user_ready_${n}  "\
    "rst_done            up_ch_rst_done_${n}    "\
    "prbsforceerr        up_ch_prbsforceerr_${n}"\
    "prbssel             up_ch_prbssel_${n}     "\
    "prbscntreset        up_ch_prbscntreset_${n}"\
    "prbserr             up_ch_prbserr_${n}     "\
    "prbslocked          up_ch_prbslocked_${n}  "\
    "bufstatus           up_ch_bufstatus_${n}   "\
    "bufstatus_rst       up_ch_bufstatus_rst_${n}"\
    "lpm_dfe_n           up_ch_lpm_dfe_n_${n}   "\
    "rate                up_ch_rate_${n}        "\
    "sys_clk_sel         up_ch_sys_clk_sel_${n} "\
    "out_clk_sel         up_ch_out_clk_sel_${n} "\
    "tx_diffctrl         up_ch_tx_diffctrl_${n}  "\
    "tx_postcursor       up_ch_tx_postcursor_${n} "\
    "tx_precursor        up_ch_tx_precursor_${n} "\
    "enb                 up_ch_enb_${n}         "\
    "addr                up_ch_addr_${n}        "\
    "wr                  up_ch_wr_${n}          "\
    "wdata               up_ch_wdata_${n}       "\
    "rdata               up_ch_rdata_${n}       "\
    "ready               up_ch_ready_${n}       "]

}

ipx::infer_bus_interface up_pll_rst xilinx.com:signal:reset_rtl:1.0 [ipx::current_core]
ipx::add_bus_parameter POLARITY [ipx::get_bus_interfaces up_pll_rst -of_objects [ipx::current_core]]
set_property VALUE ACTIVE_HIGH [ipx::get_bus_parameters POLARITY -of [ipx::get_bus_interfaces up_pll_rst]]

ipx::infer_bus_interface s_axi_aclk xilinx.com:signal:clock_rtl:1.0 [ipx::current_core]
ipx::infer_bus_interface s_axi_aresetn xilinx.com:signal:reset_rtl:1.0 [ipx::current_core]

ipx::associate_bus_interfaces -clock s_axi_aclk -reset up_pll_rst -remove [ipx::current_core]

set_property value s_axi:m_axi [ipx::get_bus_parameters ASSOCIATED_BUSIF \
  -of_objects [ipx::get_bus_interfaces s_axi_aclk -of_objects [ipx::current_core]]]

set_property enablement_dependency \
  {spirit:decode(id('MODELPARAM_VALUE.TX_OR_RX_N')) = 0} \
  [ipx::get_bus_interfaces m_axi -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.TX_OR_RX_N')) = 0) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 0))} \
  [ipx::get_bus_interfaces up_es_0 -of_objects [ipx::current_core]]

set_property enablement_dependency {spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 0} \
  [ipx::get_bus_interfaces up_ch_0 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.QPLL_ENABLE')) = 1) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 0))} \
  [ipx::get_bus_interfaces up_cm_0 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.TX_OR_RX_N')) = 0) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 1))} \
  [ipx::get_bus_interfaces up_es_1 -of_objects [ipx::current_core]]

set_property enablement_dependency {spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 1} \
  [ipx::get_bus_interfaces up_ch_1 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.TX_OR_RX_N')) = 0) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 2))} \
  [ipx::get_bus_interfaces up_es_2 -of_objects [ipx::current_core]]

set_property enablement_dependency {spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 2} \
  [ipx::get_bus_interfaces up_ch_2 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.TX_OR_RX_N')) = 0) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 3))} \
  [ipx::get_bus_interfaces up_es_3 -of_objects [ipx::current_core]]

set_property enablement_dependency {spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 3} \
  [ipx::get_bus_interfaces up_ch_3 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.TX_OR_RX_N')) = 0) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 4))} \
  [ipx::get_bus_interfaces up_es_4 -of_objects [ipx::current_core]]

set_property enablement_dependency {spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 4} \
  [ipx::get_bus_interfaces up_ch_4 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.QPLL_ENABLE')) = 1) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 4))} \
  [ipx::get_bus_interfaces up_cm_4 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.TX_OR_RX_N')) = 0) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 5))} \
  [ipx::get_bus_interfaces up_es_5 -of_objects [ipx::current_core]]

set_property enablement_dependency {spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 5} \
  [ipx::get_bus_interfaces up_ch_5 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.TX_OR_RX_N')) = 0) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 6))} \
  [ipx::get_bus_interfaces up_es_6 -of_objects [ipx::current_core]]

set_property enablement_dependency {spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 6} \
  [ipx::get_bus_interfaces up_ch_6 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.TX_OR_RX_N')) = 0) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 7))} \
  [ipx::get_bus_interfaces up_es_7 -of_objects [ipx::current_core]]

set_property enablement_dependency {spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 7} \
  [ipx::get_bus_interfaces up_ch_7 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.TX_OR_RX_N')) = 0) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 8))} \
  [ipx::get_bus_interfaces up_es_8 -of_objects [ipx::current_core]]

set_property enablement_dependency {spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 8} \
  [ipx::get_bus_interfaces up_ch_8 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.QPLL_ENABLE')) = 1) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 8))} \
  [ipx::get_bus_interfaces up_cm_8 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.TX_OR_RX_N')) = 0) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 9))} \
  [ipx::get_bus_interfaces up_es_9 -of_objects [ipx::current_core]]

set_property enablement_dependency {spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 9} \
  [ipx::get_bus_interfaces up_ch_9 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.TX_OR_RX_N')) = 0) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 10))} \
  [ipx::get_bus_interfaces up_es_10 -of_objects [ipx::current_core]]

set_property enablement_dependency {spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 10} \
  [ipx::get_bus_interfaces up_ch_10 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.TX_OR_RX_N')) = 0) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 11))} \
  [ipx::get_bus_interfaces up_es_11 -of_objects [ipx::current_core]]

set_property enablement_dependency {spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 11} \
  [ipx::get_bus_interfaces up_ch_11 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.TX_OR_RX_N')) = 0) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 12))} \
  [ipx::get_bus_interfaces up_es_12 -of_objects [ipx::current_core]]

set_property enablement_dependency {spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 12} \
  [ipx::get_bus_interfaces up_ch_12 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.QPLL_ENABLE')) = 1) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 12))} \
  [ipx::get_bus_interfaces up_cm_12 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.TX_OR_RX_N')) = 0) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 13))} \
  [ipx::get_bus_interfaces up_es_13 -of_objects [ipx::current_core]]

set_property enablement_dependency {spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 13} \
  [ipx::get_bus_interfaces up_ch_13 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.TX_OR_RX_N')) = 0) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 14))} \
  [ipx::get_bus_interfaces up_es_14 -of_objects [ipx::current_core]]

set_property enablement_dependency {spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 14} \
  [ipx::get_bus_interfaces up_ch_14 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.TX_OR_RX_N')) = 0) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 15))} \
  [ipx::get_bus_interfaces up_es_15 -of_objects [ipx::current_core]]

set_property enablement_dependency {spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 15} \
  [ipx::get_bus_interfaces up_ch_15 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.TX_OR_RX_N')) = 0) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 16))} \
  [ipx::get_bus_interfaces up_es_16 -of_objects [ipx::current_core]]

set_property enablement_dependency {spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 16} \
  [ipx::get_bus_interfaces up_ch_16 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.QPLL_ENABLE')) = 1) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 16))} \
  [ipx::get_bus_interfaces up_cm_16 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.TX_OR_RX_N')) = 0) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 17))} \
  [ipx::get_bus_interfaces up_es_17 -of_objects [ipx::current_core]]

set_property enablement_dependency {spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 17} \
  [ipx::get_bus_interfaces up_ch_17 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.TX_OR_RX_N')) = 0) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 18))} \
  [ipx::get_bus_interfaces up_es_18 -of_objects [ipx::current_core]]

set_property enablement_dependency {spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 18} \
  [ipx::get_bus_interfaces up_ch_18 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.TX_OR_RX_N')) = 0) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 19))} \
  [ipx::get_bus_interfaces up_es_19 -of_objects [ipx::current_core]]

set_property enablement_dependency {spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 19} \
  [ipx::get_bus_interfaces up_ch_19 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.TX_OR_RX_N')) = 0) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 20))} \
  [ipx::get_bus_interfaces up_es_20 -of_objects [ipx::current_core]]

set_property enablement_dependency {spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 20} \
  [ipx::get_bus_interfaces up_ch_20 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.QPLL_ENABLE')) = 1) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 20))} \
  [ipx::get_bus_interfaces up_cm_20 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.TX_OR_RX_N')) = 0) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 21))} \
  [ipx::get_bus_interfaces up_es_21 -of_objects [ipx::current_core]]

set_property enablement_dependency {spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 21} \
  [ipx::get_bus_interfaces up_ch_21 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.TX_OR_RX_N')) = 0) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 22))} \
  [ipx::get_bus_interfaces up_es_22 -of_objects [ipx::current_core]]

set_property enablement_dependency {spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 22} \
  [ipx::get_bus_interfaces up_ch_22 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.TX_OR_RX_N')) = 0) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 23))} \
  [ipx::get_bus_interfaces up_es_23 -of_objects [ipx::current_core]]

set_property enablement_dependency {spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 23} \
  [ipx::get_bus_interfaces up_ch_23 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.TX_OR_RX_N')) = 0) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 24))} \
  [ipx::get_bus_interfaces up_es_24 -of_objects [ipx::current_core]]

set_property enablement_dependency {spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 24} \
  [ipx::get_bus_interfaces up_ch_24 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.QPLL_ENABLE')) = 1) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 24))} \
  [ipx::get_bus_interfaces up_cm_24 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.TX_OR_RX_N')) = 0) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 25))} \
  [ipx::get_bus_interfaces up_es_25 -of_objects [ipx::current_core]]

set_property enablement_dependency {spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 25} \
  [ipx::get_bus_interfaces up_ch_25 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.TX_OR_RX_N')) = 0) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 26))} \
  [ipx::get_bus_interfaces up_es_26 -of_objects [ipx::current_core]]

set_property enablement_dependency {spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 26} \
  [ipx::get_bus_interfaces up_ch_26 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.TX_OR_RX_N')) = 0) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 27))} \
  [ipx::get_bus_interfaces up_es_27 -of_objects [ipx::current_core]]

set_property enablement_dependency {spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 27} \
  [ipx::get_bus_interfaces up_ch_27 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.TX_OR_RX_N')) = 0) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 28))} \
  [ipx::get_bus_interfaces up_es_28 -of_objects [ipx::current_core]]

set_property enablement_dependency {spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 28} \
  [ipx::get_bus_interfaces up_ch_28 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.QPLL_ENABLE')) = 1) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 28))} \
  [ipx::get_bus_interfaces up_cm_28 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.TX_OR_RX_N')) = 0) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 29))} \
  [ipx::get_bus_interfaces up_es_29 -of_objects [ipx::current_core]]

set_property enablement_dependency {spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 29} \
  [ipx::get_bus_interfaces up_ch_29 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.TX_OR_RX_N')) = 0) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 30))} \
  [ipx::get_bus_interfaces up_es_30 -of_objects [ipx::current_core]]

set_property enablement_dependency {spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 30} \
  [ipx::get_bus_interfaces up_ch_30 -of_objects [ipx::current_core]]

set_property enablement_dependency \
  {((spirit:decode(id('MODELPARAM_VALUE.TX_OR_RX_N')) = 0) and \
  (spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 31))} \
  [ipx::get_bus_interfaces up_es_31 -of_objects [ipx::current_core]]

set_property enablement_dependency {spirit:decode(id('MODELPARAM_VALUE.NUM_OF_LANES')) > 31} \
  [ipx::get_bus_interfaces up_ch_31 -of_objects [ipx::current_core]]

adi_add_auto_fpga_spec_params
ipx::create_xgui_files [ipx::current_core]

ipx::save_core [ipx::current_core]

