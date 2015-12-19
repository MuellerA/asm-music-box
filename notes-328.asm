pitch:
.byte 0x05, 0x77 ; [00] C_0     65.41
.byte 0x05, 0x70 ; [01] CIS_0   69.30
.byte 0x05, 0x6a ; [02] D_0     73.42
.byte 0x05, 0x64 ; [03] DIS_0   77.78
.byte 0x05, 0x5e ; [04] E_0     82.41
.byte 0x05, 0x59 ; [05] F_0     87.31
.byte 0x05, 0x54 ; [06] FIS_0   92.50
.byte 0x05, 0x4f ; [07] G_0     98.00
.byte 0x05, 0x4b ; [08] GIS_0  103.83
.byte 0x05, 0x47 ; [09] A_0    110.00
.byte 0x05, 0x43 ; [0a] AIS_0  116.54
.byte 0x04, 0xfd ; [0b] H_0    123.47
.byte 0x04, 0xee ; [0c] C_1    130.81
.byte 0x04, 0xe1 ; [0d] CIS_1  138.59
.byte 0x04, 0xd4 ; [0e] D_1    146.83
.byte 0x04, 0xc8 ; [0f] DIS_1  155.56
.byte 0x04, 0xbd ; [10] E_1    164.81
.byte 0x04, 0xb2 ; [11] F_1    174.61
.byte 0x04, 0xa8 ; [12] FIS_1  185.00
.byte 0x04, 0x9f ; [13] G_1    196.00
.byte 0x04, 0x96 ; [14] GIS_1  207.65
.byte 0x04, 0x8e ; [15] A_1    220.00
.byte 0x04, 0x86 ; [16] AIS_1  233.08
.byte 0x04, 0x7e ; [17] H_1    246.94
.byte 0x04, 0x77 ; [18] C_2    261.63
.byte 0x04, 0x70 ; [19] CIS_2  277.18
.byte 0x04, 0x6a ; [1a] D_2    293.66
.byte 0x04, 0x64 ; [1b] DIS_2  311.13
.byte 0x04, 0x5e ; [1c] E_2    329.63
.byte 0x04, 0x59 ; [1d] F_2    349.23
.byte 0x04, 0x54 ; [1e] FIS_2  369.99
.byte 0x04, 0x4f ; [1f] G_2    392.00
.byte 0x04, 0x4b ; [20] GIS_2  415.30
.byte 0x04, 0x47 ; [21] A_2    440.00
.byte 0x04, 0x43 ; [22] AIS_2  466.16
.byte 0x03, 0xfd ; [23] H_2    493.88
.byte 0x03, 0xee ; [24] C_3    523.25
.byte 0x03, 0xe1 ; [25] CIS_3  554.37
.byte 0x03, 0xd4 ; [26] D_3    587.33
.byte 0x03, 0xc8 ; [27] DIS_3  622.25
.byte 0x03, 0xbd ; [28] E_3    659.26
.byte 0x03, 0xb2 ; [29] F_3    698.46
.byte 0x03, 0xa8 ; [2a] FIS_3  739.99
.byte 0x03, 0x9f ; [2b] G_3    783.99
.byte 0x03, 0x96 ; [2c] GIS_3  830.61
.byte 0x03, 0x8e ; [2d] A_3    880.00
.byte 0x03, 0x86 ; [2e] AIS_3  932.33
.byte 0x03, 0x7e ; [2f] H_3    987.77
.byte 0x03, 0x77 ; [30] C_4   1046.50
.byte 0x03, 0x70 ; [31] CIS_4 1108.73
.byte 0x03, 0x6a ; [32] D_4   1174.66
.byte 0x03, 0x64 ; [33] DIS_4 1244.51
.byte 0x03, 0x5e ; [34] E_4   1318.51
.byte 0x03, 0x59 ; [35] F_4   1396.91
.byte 0x03, 0x54 ; [36] FIS_4 1479.98
.byte 0x03, 0x4f ; [37] G_4   1567.98
.byte 0x03, 0x4b ; [38] GIS_4 1661.22
.byte 0x03, 0x47 ; [39] A_4   1760.00
.byte 0x03, 0x43 ; [3a] AIS_4 1864.66
.byte 0x03, 0x3f ; [3b] H_4   1975.53
duration:
.byte 0x80, 0x57, 0x40, 0x06 ; [00] 1.0
.byte 0x40, 0x06, 0x80, 0x57 ; [00] 1.0 .
.byte 0xc0, 0x5d, 0x00, 0x00 ; [00] 1.0 ~
.byte 0x00, 0x00, 0x00, 0x00 ;
.byte 0x60, 0x86, 0x40, 0x06 ; [01] 1.0.
.byte 0x40, 0x06, 0x60, 0x86 ; [01] 1.0. .
.byte 0xa0, 0x8c, 0x00, 0x00 ; [01] 1.0. ~
.byte 0x00, 0x00, 0x00, 0x00 ;
.byte 0x30, 0x2a, 0xaf, 0x04 ; [02] 2.0
.byte 0x40, 0x06, 0xa0, 0x28 ; [02] 2.0 .
.byte 0xe0, 0x2e, 0x00, 0x00 ; [02] 2.0 ~
.byte 0x00, 0x00, 0x00, 0x00 ;
.byte 0x10, 0x40, 0x40, 0x06 ; [03] 2.0.
.byte 0x40, 0x06, 0x10, 0x40 ; [03] 2.0. .
.byte 0x50, 0x46, 0x00, 0x00 ; [03] 2.0. ~
.byte 0x00, 0x00, 0x00, 0x00 ;
.byte 0x18, 0x15, 0x57, 0x02 ; [04] 4.0
.byte 0xaf, 0x04, 0xc0, 0x12 ; [04] 4.0 .
.byte 0x70, 0x17, 0x00, 0x00 ; [04] 4.0 ~
.byte 0x00, 0x00, 0x00, 0x00 ;
.byte 0xa4, 0x1f, 0x84, 0x03 ; [05] 4.0.
.byte 0x40, 0x06, 0xe8, 0x1c ; [05] 4.0. .
.byte 0x28, 0x23, 0x00, 0x00 ; [05] 4.0. ~
.byte 0x00, 0x00, 0x00, 0x00 ;
.byte 0x8c, 0x0a, 0x2b, 0x01 ; [06] 8.0
.byte 0x57, 0x02, 0x60, 0x09 ; [06] 8.0 .
.byte 0xb8, 0x0b, 0x00, 0x00 ; [06] 8.0 ~
.byte 0x00, 0x00, 0x00, 0x00 ;
.byte 0xd2, 0x0f, 0xc2, 0x01 ; [07] 8.0.
.byte 0x83, 0x03, 0x10, 0x0e ; [07] 8.0. .
.byte 0x94, 0x11, 0x00, 0x00 ; [07] 8.0. ~
.byte 0x00, 0x00, 0x00, 0x00 ;
.byte 0x46, 0x05, 0x95, 0x00 ; [08] 16.0
.byte 0x2b, 0x01, 0xb0, 0x04 ; [08] 16.0 .
.byte 0xdc, 0x05, 0x00, 0x00 ; [08] 16.0 ~
.byte 0x00, 0x00, 0x00, 0x00 ;
.byte 0xe9, 0x07, 0xe1, 0x00 ; [09] 16.0.
.byte 0xc1, 0x01, 0x08, 0x07 ; [09] 16.0. .
.byte 0xca, 0x08, 0x00, 0x00 ; [09] 16.0. ~
.byte 0x00, 0x00, 0x00, 0x00 ;
.byte 0xa3, 0x02, 0x4a, 0x00 ; [0a] 32.0
.byte 0x95, 0x00, 0x58, 0x02 ; [0a] 32.0 .
.byte 0xee, 0x02, 0x00, 0x00 ; [0a] 32.0 ~
.byte 0x00, 0x00, 0x00, 0x00 ;
.byte 0xf4, 0x03, 0x70, 0x00 ; [0b] 32.0.
.byte 0xe0, 0x00, 0x84, 0x03 ; [0b] 32.0. .
.byte 0x65, 0x04, 0x00, 0x00 ; [0b] 32.0. ~
.byte 0x00, 0x00, 0x00, 0x00 ;
.byte 0x51, 0x01, 0x25, 0x00 ; [0c] 64.0
.byte 0x4a, 0x00, 0x2c, 0x01 ; [0c] 64.0 .
.byte 0x77, 0x01, 0x00, 0x00 ; [0c] 64.0 ~
.byte 0x00, 0x00, 0x00, 0x00 ;
.byte 0xfa, 0x01, 0x38, 0x00 ; [0d] 64.0.
.byte 0x70, 0x00, 0xc2, 0x01 ; [0d] 64.0. .
.byte 0x32, 0x02, 0x00, 0x00 ; [0d] 64.0. ~
.byte 0x00, 0x00, 0x00, 0x00 ;