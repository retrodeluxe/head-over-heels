	;;
	;; data_trailer.asm
	;;
	;; Data that occurs after the main code section.
	;; 
	;; Mostly sprites, 128K code, and, er, the stack.
	;;
	;; FIXME: Disassemble the 128K code!
	;;
	;; FIXME: Identify the remaining bits and pieces.
	;;

        
	;; This buffer gets filled with info that DrawFloor reads.
	;; 16 words describing the 16 double-columns
	;;
	;; NB: Page-aligned
	;;
	;; Byte 0: Y start (0 = clear)
	;; Byte 1: Id for wall panel sprite
	;;         (0-3 - world-specific, 4 - blank, 5 - columns, | $80 to flip)
BkgndData:      EQU $BA00
LBA40:		EQU $BA40
LBA48:		EQU $BA48

	;; NB: Not sure what this brief interlude is for!
XB867:	DEFB $F3,$21,$D3,$BD,$11,$00,$40,$01
XB86F:	DEFB $05,$00,$ED,$B0,$11,$00,$5B,$01,$00,$A5,$21,$54,$60,$C3,$00,$40
XB87F:	DEFB $ED,$B0,$C3,$30,$70

	;; NB: This is 128K-specific code, copied into another bank.
#include "128k.asm"
	;; End of 128K code.

	;; Start of area that gets moved down...
MoveDownStart:

PanelFlips:	DEFB $00,$00,$00,$00,$00,$00,$00,$00

;; Bitmap of whether the nth sprite is store in flipped format.
SpriteFlips:	DEFS $10,$00

	;;  Background wall tiles
IMG_WALLS:
#insert "img_walls.bin"

	DEFB $90,$00,$A0,$00

IMG_3x56:
#insert "img_3x56.bin"
IMG_3x32:	
#insert "img_3x32.bin"
IMG_3x24:			
#insert "img_3x24.bin"
IMG_4x28:			
#insert "img_4x28.bin"
IMG_2x24:
#insert "img_2x24.bin"
IMG_CHARS:
#insert "img_chars.bin"

	;; FIXME: Make into binaries
IMG_ColTop:
	DEFB $00,$03,$00,$03,$00,$3C,$00,$CF,$01,$F3,$0E,$7C,$3F,$9F,$FF
	DEFB $3C,$FC,$F3,$F3,$CF,$CF,$3E,$3C,$F8,$F3,$E4,$CF,$9C,$3E,$78,$79
	DEFB $F8,$67,$F0,$07,$C8

IMG_ColMid:	
	DEFB $78,$3C,$1F,$F0,$27,$C8,$38,$38,$5F,$F4,$4C
	DEFB $64,$73,$9C,$1E,$F0,$23,$88,$3C,$78,$1F,$F0,$27,$C8

IMG_ColBottom:
	DEFB $78,$3C,$7F
	DEFB $FC,$3F,$F8,$0F,$E0,$00,$00,$00,$00,$00,$00,$00
	DEFB $00
	;; End of area that gets moved down.

MoveDownEnd:
        
XFAAC:	DEFB $00,$00,$00
XFAAF:	DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
XFABF:	DEFB $65,$72,$20,$20,$20,$20,$20,$20,$EA,$06,$00,$00,$48,$05,$0D,$00
XFACF:	DEFB $00,$22,$0D,$80,$00,$00,$70,$5C,$00,$00,$00,$00,$00,$00,$00,$00
XFADF:	DEFB $00,$00,$00,$00,$00,$00,$00,$00,$65,$72,$20,$20,$20,$20,$20,$20
XFAEF:	DEFB $EA,$06,$00,$00,$48,$05,$0D,$00,$00,$22,$0D,$80,$00,$00,$70,$5C
XFAFF:	DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
XFB0F:	DEFB $65,$72,$20,$20,$20,$20,$20,$20,$EA,$06,$00,$00,$48,$05,$0D,$00
XFB1F:	DEFB $00,$22,$0D,$80,$00,$00,$70,$5C,$00,$00,$00,$00,$00,$00,$00,$00
XFB2F:	DEFB $00,$00,$00,$00,$00,$00,$00,$00,$65,$72,$20,$20,$20,$20,$20,$20
XFB3F:	DEFB $EA,$06,$00,$00,$48,$05,$0D,$00,$00,$22,$0D,$80,$00,$00,$70,$5C
XFB4F:	DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
XFB5F:	DEFB $65,$72,$20,$20,$20,$20,$20,$20,$EA,$06,$00,$00,$48,$05,$0D,$00
XFB6F:	DEFB $00,$22,$0D,$80,$00,$00,$70,$5C,$00,$00,$00,$00,$00,$00,$00,$00
XFB7F:	DEFB $00,$00,$00,$00,$00,$00,$00,$00,$65,$72,$20,$20,$20,$20,$20,$20
XFB8F:	DEFB $EA,$06,$00,$00,$48,$05,$0D,$00,$00,$22,$0D,$80,$00,$00,$70,$5C
XFB9F:	DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
XFBAF:	DEFB $65,$72,$20,$20,$20,$20,$20,$20,$EA,$06,$00,$00,$48,$05,$0D,$00
XFBBF:	DEFB $00,$22,$0D,$80,$00,$00,$70,$5C,$00,$00,$00,$00,$00,$00,$00,$00
XFBCF:	DEFB $00,$00,$00,$00,$00,$00,$00,$00,$65,$72,$20,$20,$20,$20,$20,$20
XFBDF:	DEFB $EA,$06,$00,$00,$48,$05,$0D,$00,$00,$22,$0D,$80,$00,$00,$70,$5C
XFBEF:	DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
XFBFF:	DEFB $65,$72,$20,$20,$20,$20,$20,$20,$EA,$06,$00,$00,$48,$05,$0D,$00
XFC0F:	DEFB $00,$22,$0D,$80,$00,$00,$70,$5C,$00,$00,$00,$00,$00,$00,$00,$00
XFC1F:	DEFB $00,$00,$00,$00,$00,$00,$00,$00,$65,$72,$20,$20,$20,$20,$20,$20
XFC2F:	DEFB $EA,$06,$00,$00,$48,$05,$0D,$00,$00,$22,$0D,$80,$00,$00,$70,$5C
XFC3F:	DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
XFC4F:	DEFB $65,$72,$20,$20,$20,$20,$20,$20,$EA,$06,$00,$00,$48,$05,$0D,$00
XFC5F:	DEFB $00,$22,$0D,$80,$00,$00,$70,$5C,$00,$00,$00,$00,$00,$00,$00,$00
XFC6F:	DEFB $00,$00,$00,$00,$00,$00,$00,$00,$65,$72,$20,$20,$20,$20,$20,$20
XFC7F:	DEFB $EA,$06,$00,$00,$48,$05,$0D,$00,$00,$22,$0D,$80,$00,$00,$70,$5C
XFC8F:	DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
XFC9F:	DEFB $65,$72,$20,$20,$42,$55,$47,$7E,$4F,$46,$46,$3B,$3B,$FD,$26,$FC
XFCAF:	DEFB $FD,$2E,$D1,$FD,$E3,$01,$2E,$00,$FD,$09,$FD,$5D,$FD,$54,$6B,$62
XFCBF:	DEFB $01,$E8,$02,$ED,$57,$E4,$08,$30,$ED,$5F,$AE,$77,$ED,$A0,$E0,$3B
XFCCF:	DEFB $3B,$E8,$C9,$C9,$C9,$C9,$C9,$C9,$C9,$C9,$C9,$C9,$C9,$C9,$C9,$C9
XFCDF:	DEFB $C9,$C9,$C9,$C9,$C9,$C9,$C9,$C9,$C9,$C9,$C9,$C9,$C9,$C9,$C9,$C9
XFCEF:	DEFB $C9,$C9,$C9,$C9,$C9,$C9,$C9,$C9,$C9,$C9,$C9,$C9,$C9,$C9,$C9,$C9
XFCFF:	DEFB $C9,$C9,$C9,$C9,$C9,$C9,$C9,$C9,$C9,$C9,$C9,$C9,$C9,$C9,$C9,$A7
XFD0F:	DEFB $ED,$52,$08,$21,$D1,$FC,$06,$3D,$36,$C9,$23,$10,$FB,$08,$CA,$37
XFD1F:	DEFB $FF,$FD,$21,$00,$00,$FD,$36,$75,$00,$FD,$23,$18,$F8,$3D,$20,$FD
XFD2F:	DEFB $A7,$04,$C8,$3E,$7F,$DB,$FE,$1F,$A9,$E6,$20,$28,$F4,$79,$2F,$4F
XFD3F:	DEFB $E6,$01,$F6,$08,$D3,$FE,$37,$C9,$F3,$14,$15,$3E,$02,$32,$40,$FD
XFD4F:	DEFB $3E,$0F,$D3,$FE,$21,$7E,$FF,$E5,$DB,$FE,$1F,$E6,$20,$4F,$BF,$CD
XFD5F:	DEFB $2C,$FD,$30,$FB,$21,$15,$04,$10,$FE,$2B,$7C,$B5,$20,$F9,$3E,$0A
XFD6F:	DEFB $CD,$2C,$FD,$30,$EA,$06,$C4,$3E,$16,$CD,$2C,$FD,$30,$E1,$3E,$D6
XFD7F:	DEFB $B8,$38,$F2,$06,$C4,$3E,$16,$CD,$2C,$FD,$30,$D3,$3E,$DF,$B8,$38
XFD8F:	DEFB $E4,$FD,$21,$88,$FF,$FD,$66,$00,$06,$C4,$3E,$16,$CD,$2C,$FD,$30
XFD9F:	DEFB $BE,$3E,$CD,$B8,$30,$DD,$24,$20,$EF,$06,$60,$3E,$16,$CD,$2C,$FD
XFDAF:	DEFB $30,$AD,$3E,$16,$CD,$2C,$FD,$30,$A6,$3E,$AB,$B8,$38,$0A,$FD,$23
XFDBF:	DEFB $FD,$7D,$FE,$8C,$20,$CF,$18,$C9,$3E,$01,$32,$40,$FD,$06,$B0,$2E
XFDCF:	DEFB $04,$3E,$0B,$18,$02,$3E,$0C,$CD,$2C,$FD,$D0,$00,$00,$3E,$0E,$CD
XFDDF:	DEFB $2C,$FD,$D0,$3E,$13,$3E,$C3,$B8,$CB,$15,$06,$B0,$D2,$D4,$FD,$3E
XFDEF:	DEFB $3A,$BD,$C2,$20,$FD,$26,$86,$26,$00,$06,$C4,$2E,$01,$FD,$21,$8C
XFDFF:	DEFB $FF,$3E,$07,$18,$16,$3E,$91,$AD,$C6,$86,$DD,$77,$00,$DD,$23,$1B
XFE0F:	DEFB $06,$C4,$2E,$01,$00,$3E,$05,$18,$02,$3E,$0C,$CD,$2C,$FD,$D0,$00
XFE1F:	DEFB $00,$3E,$0E,$CD,$2C,$FD,$D0,$3E,$13,$3E,$D7,$B8,$CB,$15,$06,$C4
XFE2F:	DEFB $D2,$18,$FE,$7C,$AD,$67,$7A,$B3,$20,$CB,$C3,$7D,$FF,$3E,$91,$AD
XFE3F:	DEFB $C6,$86,$DD,$77,$00,$DD,$23,$1B,$2E,$02,$3E,$04,$06,$B3,$CD,$B3
XFE4F:	DEFB $FE,$D0,$FD,$7E,$04,$B7,$28,$56,$69,$01,$FD,$7F,$ED,$79,$FD,$4E
XFE5F:	DEFB $00,$FD,$46,$01,$DD,$21,$00,$00,$DD,$09,$4D,$3E,$01,$2E,$02,$06
XFE6F:	DEFB $B3,$CD,$B3,$FE,$D0,$3E,$7F,$BD,$28,$03,$32,$36,$FF,$2E,$02,$3E
XFE7F:	DEFB $08,$06,$B3,$CD,$B3,$FE,$D0,$FD,$5E,$02,$FD,$56,$03,$69,$01,$05
XFE8F:	DEFB $00,$FD,$09,$4D,$7B,$B2,$06,$C4,$2E,$01,$3E,$05,$C2,$1A,$FE,$11
XFE9F:	DEFB $7D,$FF,$ED,$53,$3A,$FE,$11,$84,$03,$3E,$01,$C3,$1A,$FE,$3E,$06
XFEAF:	DEFB $18,$BB,$3E,$0C,$CD,$2C,$FD,$00,$00,$3E,$0E,$CD,$2C,$FD,$D0,$3E
XFEBF:	DEFB $DB,$B8,$CB,$15,$06,$B3,$D2,$B1,$FE,$C9,$CD,$47,$FD,$21,$00,$90
XFECF:	DEFB $06,$FF,$C5,$CD,$DE,$FE,$73,$23,$C1,$10,$F7,$CD,$FA,$FE,$C9,$1E
XFEDF:	DEFB $00,$4B,$06,$FF,$3E,$7F,$DB,$FE,$E6,$40,$A9,$28,$09,$1C,$79,$2F
XFEEF:	DEFB $E6,$40,$4F,$10,$EF,$C9,$00,$00,$C3,$F2,$FE,$21,$00,$00,$11,$32
XFEFF:	DEFB $90,$06,$32,$C5,$1A,$06,$00,$4F,$09,$13,$C1,$10,$F6,$E5,$21,$00
XFF0F:	DEFB $00,$11,$CD,$90,$06,$32,$C5,$1A,$06,$00,$4F,$09,$13,$C1,$10,$F6
XFF1F:	DEFB $C1,$7C,$FE,$0D,$30,$0D,$A7,$ED,$42,$D8,$01,$32,$00,$A7,$ED,$42
XFF2F:	DEFB $D8,$3E,$01,$32,$36,$FF,$C9,$00,$F3,$31,$FF,$FF,$21,$00,$58,$01
XFF3F:	DEFB $03,$00,$36,$00,$23,$10,$FB,$0D,$20,$F8,$DD,$21,$00,$A0,$11,$11
XFF4F:	DEFB $00,$CD,$C9,$FE,$DD,$21,$00,$40,$11,$FF,$1A,$21,$3C,$FE,$22,$3A
XFF5F:	DEFB $FE,$CD,$47,$FD,$3A,$36,$FF,$B7,$C4,$20,$FD,$FD,$21,$3A,$5C,$ED
XFF6F:	DEFB $56,$21,$58,$27,$D9,$AF,$ED,$4F,$31,$FF,$FF,$C3,$30,$70,$D1,$AF
XFF7F:	DEFB $D3,$FE,$7C,$FE,$01,$D8,$CD,$20,$FD,$18,$28,$22,$20,$A8,$61,$2F
XFF8F:	DEFB $23,$10,$D8,$D6,$D9,$23,$10,$04,$FE,$01,$00,$10,$3C,$FE,$03,$00
XFF9F:	DEFB $10,$D0,$84,$55,$2F,$10,$63,$FF,$19,$00,$10,$00,$5B,$AD,$06,$10
XFFAF:	DEFB $1E,$B4,$3F,$1F,$10,$00,$00,$00,$00,$00,$DD,$F9,$80,$FD,$CB,$01
XFFBF:	DEFB $A6,$2E,$24,$D9,$DD,$00,$80,$00,$00,$7C,$B8,$02,$0F,$B1,$33,$00
XFFCF:	DEFB $80,$00,$00,$8A,$B8,$02,$0F,$B1,$33,$00,$80,$00,$00,$E0,$B8,$02
XFFDF:	DEFB $0F,$B1,$33,$BB,$63,$6A,$32,$9B,$36,$65,$33,$B7,$2D,$BB,$63,$B6
XFFEF:	DEFB $63,$9C,$1E,$92,$1E,$50,$00,$1F,$BD,$FE,$25,$FE,$7E,$FF,$63,$FF
