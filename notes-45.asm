pitch:
.byte 0x03, 0x77 ; [00] C_0     65.41
.byte 0x03, 0x70 ; [01] CIS_0   69.30
.byte 0x03, 0x6a ; [02] D_0     73.42
.byte 0x03, 0x64 ; [03] DIS_0   77.78
.byte 0x03, 0x5e ; [04] E_0     82.41
.byte 0x03, 0x59 ; [05] F_0     87.31
.byte 0x03, 0x54 ; [06] FIS_0   92.50
.byte 0x03, 0x4f ; [07] G_0     98.00
.byte 0x03, 0x4b ; [08] GIS_0  103.83
.byte 0x03, 0x47 ; [09] A_0    110.00
.byte 0x03, 0x43 ; [0a] AIS_0  116.54
.byte 0x03, 0x3f ; [0b] H_0    123.47
.byte 0x03, 0x3b ; [0c] C_1    130.81
.byte 0x03, 0x38 ; [0d] CIS_1  138.59
.byte 0x03, 0x35 ; [0e] D_1    146.83
.byte 0x03, 0x32 ; [0f] DIS_1  155.56
.byte 0x03, 0x2f ; [10] E_1    164.81
.byte 0x03, 0x2c ; [11] F_1    174.61
.byte 0x03, 0x2a ; [12] FIS_1  185.00
.byte 0x03, 0x27 ; [13] G_1    196.00
.byte 0x03, 0x25 ; [14] GIS_1  207.65
.byte 0x03, 0x23 ; [15] A_1    220.00
.byte 0x03, 0x21 ; [16] AIS_1  233.08
.byte 0x02, 0xfd ; [17] H_1    246.94
.byte 0x02, 0xee ; [18] C_2    261.63
.byte 0x02, 0xe1 ; [19] CIS_2  277.18
.byte 0x02, 0xd4 ; [1a] D_2    293.66
.byte 0x02, 0xc8 ; [1b] DIS_2  311.13
.byte 0x02, 0xbd ; [1c] E_2    329.63
.byte 0x02, 0xb2 ; [1d] F_2    349.23
.byte 0x02, 0xa8 ; [1e] FIS_2  369.99
.byte 0x02, 0x9f ; [1f] G_2    392.00
.byte 0x02, 0x96 ; [20] GIS_2  415.30
.byte 0x02, 0x8e ; [21] A_2    440.00
.byte 0x02, 0x86 ; [22] AIS_2  466.16
.byte 0x02, 0x7e ; [23] H_2    493.88
.byte 0x02, 0x77 ; [24] C_3    523.25
.byte 0x02, 0x70 ; [25] CIS_3  554.37
.byte 0x02, 0x6a ; [26] D_3    587.33
.byte 0x02, 0x64 ; [27] DIS_3  622.25
.byte 0x02, 0x5e ; [28] E_3    659.26
.byte 0x02, 0x59 ; [29] F_3    698.46
.byte 0x02, 0x54 ; [2a] FIS_3  739.99
.byte 0x02, 0x4f ; [2b] G_3    783.99
.byte 0x02, 0x4b ; [2c] GIS_3  830.61
.byte 0x02, 0x47 ; [2d] A_3    880.00
.byte 0x02, 0x43 ; [2e] AIS_3  932.33
.byte 0x02, 0x3f ; [2f] H_3    987.77
.byte 0x02, 0x3b ; [30] C_4   1046.50
.byte 0x02, 0x38 ; [31] CIS_4 1108.73
.byte 0x02, 0x35 ; [32] D_4   1174.66
.byte 0x02, 0x32 ; [33] DIS_4 1244.51
.byte 0x02, 0x2f ; [34] E_4   1318.51
.byte 0x02, 0x2c ; [35] F_4   1396.91
.byte 0x02, 0x2a ; [36] FIS_4 1479.98
.byte 0x02, 0x27 ; [37] G_4   1567.98
.byte 0x02, 0x25 ; [38] GIS_4 1661.22
.byte 0x02, 0x23 ; [39] A_4   1760.00
.byte 0x02, 0x21 ; [3a] AIS_4 1864.66
.byte 0x01, 0xfd ; [3b] H_4   1975.53
duration:
.byte 0xc0, 0x2b, 0x20, 0x03 ; [00] 1.0
.byte 0x20, 0x03, 0xc0, 0x2b ; [00] 1.0 .
.byte 0xe0, 0x2e, 0x00, 0x00 ; [00] 1.0 ~
.byte 0x00, 0x00, 0x00, 0x00 ;
.byte 0x30, 0x43, 0x20, 0x03 ; [01] 1.0.
.byte 0x20, 0x03, 0x30, 0x43 ; [01] 1.0. .
.byte 0x50, 0x46, 0x00, 0x00 ; [01] 1.0. ~
.byte 0x00, 0x00, 0x00, 0x00 ;
.byte 0x18, 0x15, 0x57, 0x02 ; [02] 2.0
.byte 0x20, 0x03, 0x50, 0x14 ; [02] 2.0 .
.byte 0x70, 0x17, 0x00, 0x00 ; [02] 2.0 ~
.byte 0x00, 0x00, 0x00, 0x00 ;
.byte 0x08, 0x20, 0x20, 0x03 ; [03] 2.0.
.byte 0x20, 0x03, 0x08, 0x20 ; [03] 2.0. .
.byte 0x28, 0x23, 0x00, 0x00 ; [03] 2.0. ~
.byte 0x00, 0x00, 0x00, 0x00 ;
.byte 0x8c, 0x0a, 0x2b, 0x01 ; [04] 4.0
.byte 0x57, 0x02, 0x60, 0x09 ; [04] 4.0 .
.byte 0xb8, 0x0b, 0x00, 0x00 ; [04] 4.0 ~
.byte 0x00, 0x00, 0x00, 0x00 ;
.byte 0xd2, 0x0f, 0xc2, 0x01 ; [05] 4.0.
.byte 0x20, 0x03, 0x74, 0x0e ; [05] 4.0. .
.byte 0x94, 0x11, 0x00, 0x00 ; [05] 4.0. ~
.byte 0x00, 0x00, 0x00, 0x00 ;
.byte 0x46, 0x05, 0x95, 0x00 ; [06] 8.0
.byte 0x2b, 0x01, 0xb0, 0x04 ; [06] 8.0 .
.byte 0xdc, 0x05, 0x00, 0x00 ; [06] 8.0 ~
.byte 0x00, 0x00, 0x00, 0x00 ;
.byte 0xe9, 0x07, 0xe1, 0x00 ; [07] 8.0.
.byte 0xc1, 0x01, 0x08, 0x07 ; [07] 8.0. .
.byte 0xca, 0x08, 0x00, 0x00 ; [07] 8.0. ~
.byte 0x00, 0x00, 0x00, 0x00 ;
.byte 0xa3, 0x02, 0x4a, 0x00 ; [08] 16.0
.byte 0x95, 0x00, 0x58, 0x02 ; [08] 16.0 .
.byte 0xee, 0x02, 0x00, 0x00 ; [08] 16.0 ~
.byte 0x00, 0x00, 0x00, 0x00 ;
.byte 0xf4, 0x03, 0x70, 0x00 ; [09] 16.0.
.byte 0xe0, 0x00, 0x84, 0x03 ; [09] 16.0. .
.byte 0x65, 0x04, 0x00, 0x00 ; [09] 16.0. ~
.byte 0x00, 0x00, 0x00, 0x00 ;
.byte 0x51, 0x01, 0x25, 0x00 ; [0a] 32.0
.byte 0x4a, 0x00, 0x2c, 0x01 ; [0a] 32.0 .
.byte 0x77, 0x01, 0x00, 0x00 ; [0a] 32.0 ~
.byte 0x00, 0x00, 0x00, 0x00 ;
.byte 0xfa, 0x01, 0x38, 0x00 ; [0b] 32.0.
.byte 0x70, 0x00, 0xc2, 0x01 ; [0b] 32.0. .
.byte 0x32, 0x02, 0x00, 0x00 ; [0b] 32.0. ~
.byte 0x00, 0x00, 0x00, 0x00 ;
.byte 0xa8, 0x00, 0x12, 0x00 ; [0c] 64.0
.byte 0x25, 0x00, 0x96, 0x00 ; [0c] 64.0 .
.byte 0xbb, 0x00, 0x00, 0x00 ; [0c] 64.0 ~
.byte 0x00, 0x00, 0x00, 0x00 ;
.byte 0xfd, 0x00, 0x1c, 0x00 ; [0d] 64.0.
.byte 0x38, 0x00, 0xe1, 0x00 ; [0d] 64.0. .
.byte 0x19, 0x01, 0x00, 0x00 ; [0d] 64.0. ~
.byte 0x00, 0x00, 0x00, 0x00 ;
