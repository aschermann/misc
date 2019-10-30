; Configuration file for Duet WiFi (firmware version 1.21)
; executed by the firmware on start-up
;
; generated by RepRapFirmware Configuration Tool v2 on Mon Mar 18 2019 21:06:52 GMT-0700 (Pacific Daylight Time)

; General preferences
G90                                          ; Send absolute coordinates...
M83                                          ; ...but relative extruder moves

M667 S1                                      ; Select CoreXY mode

; Network
M550 P"CoreXY"                               ; Set machine name
M551 P"reprap"                               ; Set password
M552 S1                                      ; Enable network
;*** Access point is configured manually via M587
M586 P0 S1                                   ; Enable HTTP
M586 P1 S1                                   ; Enable FTP
M586 P2 S1                                   ; Enable Telnet

; Drives
M569 P0 S1                                    ; Drive 0 goes forwards
M569 P1 S1                                    ; Drive 1 goes forwards
M569 P2 S1                                    ; Drive 2 goes forwards
M569 P3 S1                                    ; Drive 3 goes forwards
M350 X16 Y16 Z16 E16 I1                       ; Configure microstepping with interpolation

;M92 X200.00 Y200.00 Z400.00 E830.0            ; Set microsteps per mm
M92 X200.00 Y200.00 Z400.00 E415.0            ; Set microsteps per mm

; Based on:
; https://forum.duet3d.com/topic/8689/extruder-acceleration-jerk-and-tuning/2
; Sets:
;   M566 ....    ; max jerk
;   M201 ....    ; max acceleration 
M98 P"/sys/mode_normal.g"

; Note: too fast E speed may skip steps
M203 X15000 Y15000 Z3000 E3000                ; Set maximum speeds (mm/min)
M204 P1000 T3000			      ; Set printing and travel accelerations
M906 X1500 Y1500 Z1500 E1200 I30              ; Set motor currents (mA) and motor idle factor in per cent
M84 S30                                       ; Set idle timeout (secs)

; Axis Limits
; Setting a negative Z limit to allow room for babystepping. 
;M208 X-5 Y-15 Z-3 S1                         ; Set axis minima (home at min X,Y)
;M208 X300 Y300 Z285 S0                       ; Set axis maxima

M208 X-2:300 Y-5:300 Z-3:285                 ; XYZ min/max

; Endstops
M574 X1 Y1 S3                                ; X min, Y min, stall style endstops
M915 X Y S3 F0 R0                            ; Stall detection. Higher S value -> less sensitive

; Disable Heater 2 (E1). Used for camera click
M307 H2 A-1 C-1 D-1

; Z-Probe
M574 Z1 S2                                   ; Set endstops controlled by probe
M307 H3 A-1 C-1 D-1                          ; Disable heater on PWM channel for BLTouch
; NOTE: the T value determines also the x/y movement speed of the 
; leveling macro (which uses G30 commands)
;
; TODO: add B1 parameter to turn off bed while probing to reduce magnetic field that
; may affect BlTouch.
;
; TODO: see M588 param recomendation at https://duet3d.dozuki.com/Wiki/BLTouch_Troubleshooting
;
M558 P9 H3 F120 T12000                       ; Set Z probe type to bltouch and the dive height + speeds
; See http://www.sublimelayers.com/2017/05/fdffsd.html
; To apply babysteps value, SUBSTRACT it from the Z value here.
; (to raise head -> lower Z value here)
; (to lower head -> raise Z value here)
G31 P500 X20.5 Y12.9 Z1.450                   ; Set Z probe trigger value, offset and trigger height

; Heaters
M305 P0 T100000 B4138 R4700                  ; Set thermistor + ADC parameters for heater 0
M143 H0 S120                                 ; Set temperature limit for heater 0 to 120C
M305 P1 T100000 B4138 R4700                  ; Set thermistor + ADC parameters for heater 1
M143 H1 S280                                 ; Set temperature limit for heater 1 to 280C

; Fans
M106 P0 S0 I0 F500 H-1                       ; Set fan 0 value, PWM signal inversion and frequency. Thermostatic control is turned off
M106 P1 S1 I0 F500 H1 T45                    ; Set fan 1 value, PWM signal inversion and frequency. Thermostatic control is turned on

; Tools
M563 P0 D0 H1                                ; Define tool 0
G10 P0 X0 Y0 Z0                              ; Set tool 0 axis offsets
G10 P0 R0 S0                                 ; Set initial tool 0 active and standby temperatures to 0C

; Leveling
M671 X29:29:269:269  Y279:39:39:279 P0.7      ; positions of adjustment screws

M557 X23:279 Y30:286 S32                     ; Define mesh grid

; Bed temp PID autotune
; To autotune send [M303 H0 P1.0 S60]. Check progress with [M303]. when stage 4 done, 
; send [M307 H0] and enter results below.
;
; Heater 0 model: gain 64.1, time constant 277.0, dead time 3.2, 
;    max PWM 1.00, calibration voltage 24.2, mode PID, inverted no, frequency default
; Computed PID parameters for setpoint change: P239.7, I8.026, D540.3
; Computed PID parameters for load change: P23
; 
;M307 H0 A64.1 C277.0 D3.2 V24.2 B0
;
; Heater 0 model: gain 237.3, time constant 1430.3, dead time 1.7, 
;     max PWM 1.00, calibration voltage 24.2, mode PID, inverted no, frequency default
; Computed PID parameters for setpoint change: P629.0, I12.718, D753.1
; Computed PID parameters for load change:
M307 H0 A237.3 C1430.3 D1.7 V24.2 B0

; Hotend temp PID autotune
; To autotune send [M303 H1 P1.0 S230]. Check progress with [M303]. when stage 4 done, 
; send [M307 H1] and enter results below.
;
; Heater 1 model: gain 549.5, time constant 234.0, dead time 4.7, 
;     max PWM 1.00, calibration voltage 24.1, mode PID, inverted no, frequency default
; Computed PID parameters for setpoint change: P16.3, I0.495, D53.2
; Computed PID parameters for load change: P16.
;
M307 H1 A549.5 C234.0 D4.7 V24.1 B0

; Calibration shows that 1.15 provides best uniformity across the selected
; speed changes (for 0.2mm layer).
M572 D0 S1.2 ; set pressure advance

; Automatic saving after power loss is not enabled

; Custom settings are not configured

T0   ; select extruder
