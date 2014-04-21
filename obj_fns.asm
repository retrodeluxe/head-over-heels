	;; 
	;; obj_fns.asm
	;;
	;; The functions that implement the per-object function table.
	;;
	;; FIXME: Needs a lot of reversing!
	;; 

	;; Exports ObjFn* and L8F18.

	;; ObjectList appears to be head of a linked list:
	;; Offset 0: Next item (null == end)
	;; Offset 4: Some flag - bit 6 and 7 causes skipping
	;; Offset 5: X/Y coordinate
	;; Offset 6: Y/X coordinate
	;; Offset 7: Z coordinate, C0 = ground
	;; Offset 8: Its sprite
	;; ...?
	;; Offset C:
	;; Hmmm. May be 17 bytes?
	
ObjFn30:	LD	A,(IY+$0C)
		LD	(IY+$0C),$FF
		OR	$F0
		CP	$FF
		RET	Z
		LD	(L8EDA),A
		RET

ObjFn29:	CALL	C9319
		LD	HL,L8EDA
		LD	A,(HL)
		LD	(HL),$FF
		PUSH	AF
		CALL	LookupDir
		INC	A
		SUB	$01
		CALL	NC,L921B
		POP	AF
		CALL	C92DF
		CALL	C92CF
		JP	C92B7		; Tail call

ObjFn27:	BIT	5,(IY+$0C)
		RET	NZ
		CALL	C92CF
		CALL	C92B7
		LD	B,$47
		JP	PlaySound 	; Tail call

L8F18:	LD		H,B
ObjFn36:	LD		HL,L8F18
		LD		A,(HL)
		AND		A
		RET		NZ
		LD		(HL),$60
		LD		(IY+$0B),$F7
		LD		(IY+$0A),$19
		LD		A,$05
		JP		CharThing11
L8F2E:	NOP
ObjFn35:	LD		HL,L8F2E
		LD		(HL),$FF
		PUSH	HL
		CALL	C8F3C
		POP		HL
		LD		(HL),$00
		RET
C8F3C:	LD		A,(L822D)
		INC		A
		JR		NZ,L8F82
		LD		A,(IY+$0C)
		AND		$20
		RET		NZ
		LD		BC,(LA2BB)
		JR		L8F61
ObjFn32:	LD		A,(L822D)
		INC		A
		JR		NZ,L8F82
		CALL	C9269
		OR		$F3
		CP		C
		JR		Z,L8F61
		LD		A,C
		OR		$FC
		CP		C
		RET		NZ
L8F61:	LD		(IY+$0C),C
		JR		L8F82
ObjFn25:	CALL	C92D2
		CALL	C8F97
		JR		C,L8F71
		CALL	C8F97
L8F71:	JP		C,L905D
		JR		L8F88
ObjFn10:	LD		A,(L822D)
		INC		A
		JR		NZ,L8F82
		LD		A,(IY+$0C)
		INC		A
		JR		Z,L8F8B
L8F82:	CALL	C9319
		CALL	C8F97
L8F88:	JP		C92B7
L8F8B:	PUSH	IY
		CALL	ObjFn1
		POP		IY
		LD		(IY+$0B),$FF
		RET
C8F97:	LD		A,(L822D)
		AND		A,(IY+$0C)
		CALL	LookupDir
		CP		$FF
		SCF
		RET		Z
		CALL	C8FC0
		RET		C
		PUSH	AF
		CALL	C92A6
		POP		AF
		PUSH	AF
		CALL	C8CD3
		POP		AF
		LD		HL,(L8F2E)
		INC		L
		RET		Z
		CALL	C8FC0
		RET		C
		CALL	C8CD3
		AND		A
		RET
C8FC0:	LD		HL,(CurrObject)
		JP		TableCall
ObjFn14:	LD		A,(IY+$0C)
		OR		$C0
		INC		A
		JR		NZ,L8FD2
		LD		(IY+$11),A
		RET
L8FD2:	LD		A,(IY+$11)
		AND		A
		JR		Z,L8FDD
		LD		(IY+$0C),$FF
		RET
	
L8FDD:		DEC	(IY+$11)
		CALL	C9314
	;; Call C9005 on each object in the object list...
		LD	HL,ObjectList
L8FE6:		LD	A,(HL)
		INC	HL
		LD	H,(HL)
		LD	L,A
		OR	H
		JR	Z,L8FF7
		PUSH	HL
		PUSH	HL
		POP	IX
		CALL	C9005		; Call with the object in HL and IX
		POP	HL
		JR	L8FE6
L8FF7:		CALL	C92D6
		LD	A,(IY+$04)
		XOR	$10
		LD	(IY+$04),A
		JP	C92B7		; Tail call

C9005:		LD		A,(IX+$0A)
		AND		$7F
		CP		$0E
		RET		Z
		CP		$11
		RET		Z
		LD		A,(IX+$09)
		LD		C,A
		AND		$09
		RET		NZ
		LD		A,C
		XOR		$40
		LD		(IX+$09),A
		RET

ObjFn23:	LD 	A,$90
		DEFB 	$01			; LD BC,nn , NOPs next instruction!

ObjFn18:	LD		A,$52
		LD		(IY+$11),A
		LD		(IY+$0A),$10
		RET

ObjFn19:	BIT		5,(IY+$0C)
		RET		NZ
		CALL	C931F
		JP		C92B7
	
ObjFn2:		LD		A,$FE
		JR		Write0B

ObjFn3:		LD		A,$FD
		JR		Write0B

ObjFn4:		LD		A,$F7
		JR		Write0B

ObjFn5:		LD		A,$FB
	;; Fall through
	
Write0B:	LD		(IY+$0B),A
		LD		(IY+$0A),$00
		RET
	
ObjFn31:	LD	A,(Character)
		AND	$02			; Test if we have Head (returns early if not)
		JR	L905C

ObjFn24:	LD	A,$C0
		DEFB	$01			; LD BC,nn , NOPs next instruction!
ObjFn20		LD	A,$CF
		OR	A,(IY+$0C)
		INC	A
	;; NB: Fall through

L905C:		RET	Z	
L905D:		LD	A,$05
		CALL	CharThing11
		LD	A,(IY+$0A)
		AND	$80
		OR	$11
		LD	(IY+$0A),A
		LD	(IY+$0F),$08
ObjFn17:	LD	(IY+$04),$80
		CALL	C92A6
		CALL	C92D2
		LD	A,(IY+$0F)
		AND	$07
		JP	NZ,C92B7
ObjFn34:	LD	HL,(CurrObject)
		JP	RemoveObject

ObjFn28:	LD		B,(IY+$08)
		BIT		5,(IY+$0C)
		SET		5,(IY+$0C)
		LD		A,$2C
		JR		Z,L90B3
		LD		A,(IY+$0F)
		AND		A
		JR		NZ,L90AD
		LD		A,$2C
		CP		B
		JR		NZ,ObjFn1
		LD		(IY+$0F),$50
		LD		A,$04
		CALL	CharThing11
		JR		L90C6
L90AD:	AND		$07
		JR		NZ,L90C6
		LD		A,$2B
L90B3:	LD		(IY+$08),A
		LD		(IY+$0F),$00
		CP		B
		JR		Z,ObjFn1
		JR		L90C6
ObjFn26:	LD		A,(IY+$0F)
		AND		$F0
		JR		Z,ObjFn1
L90C6:	CALL	C92A6
		CALL	C92D2
ObjFn1:	CALL	C9319
		LD		A,$FF
		CALL	C92DF
		JP		C92B7
ObjFn22:	LD		HL,L921F
		JP		L911B

ObjFn21:	LD		HL,L920D
		JP		L911B

ObjFn6:		LD		HL,L921F
		JR		L9121

ObjFn7:		LD		HL,L920D
		JR		L9121
	
ObjFn8:		LD		HL,L9214
		JR		L9121
	
ObjFn11:	LD		HL,L9200
		JR		L9121
	
ObjFn12:	LD		HL,L9200
		JR		L9155
	
ObjFn13:	LD		HL,L91E4
		JR		L9155
	
ObjFn9:		LD		HL,L91F1
		JR		L9155
	
ObjFn15:	LD		HL,L9245
		JR		L9141

ObjFn37:	LD		A,(L866B)
		OR		$F0
		INC		A
		LD		HL,L925D
		JR		Z,L9119
		LD		HL,L9264
L9119:		JR		L9141
	
L911B:		PUSH	HL
		CALL	C92CF
		JR		L912C
	
L9121:	PUSH	HL
L9122:	CALL	C92CF
		CALL	C9319
		LD		A,$FF
		JR		C,L912F
L912C:	CALL	C936A
L912F:	CALL	C92DF
		POP		HL
		LD		A,(L8ED9)
		INC		A
		JP		Z,C92B7
		CALL	C9140
		JP		C92B7
C9140:	JP		(HL)
L9141:	PUSH	HL
		CALL	C9319
		POP		HL
		CALL	C9140
L9149:	CALL	C92CF
		CALL	C936A
		CALL	C92DF
		JP		C92B7
L9155:	PUSH	HL
		CALL	C8D18
		LD		A,L
		AND		$0F
		JR		NZ,L9122
		CALL	C9319
		POP		HL
		CALL	C9140
		CALL	C92CF
		CALL	C936A
		CALL	C92DF
		JP		C92B7
L9171:		NOP
ObjFn16:	LD		A,$01
		CALL	CharThing11
		CALL	C92CF
		LD		A,(IY+$11)
		LD		B,A
		BIT		3,A
		JR		Z,L91BE
		RRA
		RRA
		AND		$3C
		LD		C,A
		RRCA
		ADD		A,C
		NEG
		ADD		A,$C0
		CP		A,(IY+$07)
		JR		NC,L91A8
		LD		HL,(CurrObject)
		CALL	CAC41
		RES		4,(IY+$0B)
		JR		NC,L91A0
		JR		Z,L91E1
L91A0:	CALL	C92A6
		DEC		(IY+$07)
		JR		L91E1
L91A8:	LD		HL,L9171
		LD		A,(HL)
		AND		A
		JR		NZ,L91B1
		LD		(HL),$02
L91B1:	DEC		(HL)
		JR		NZ,L91E1
		LD		A,B
		XOR		$08
		LD		(IY+$11),A
		AND		$08
		JR		L91E1
L91BE:	AND		$07
		ADD		A,A
		LD		C,A
		ADD		A,A
		ADD		A,C
		NEG
		ADD		A,$BF
		CP		A,(IY+$07)
		JR		C,L91A8
		LD		HL,(CurrObject)
		CALL	CAB06
		JR		NC,L91D7
		JR		Z,L91E1
L91D7:	CALL	C92A6
		RES		5,(IY+$0B)
		INC		(IY+$07)
L91E1:	JP		C92B7
L91E4:	CALL	C8D18
		LD		A,L
		AND		$06
		CP		A,(IY+$10)
		JR		Z,L91E4
		JR		L921B
L91F1:	CALL	C8D18
		LD		A,L
		AND		$06
		OR		$01
		CP		A,(IY+$10)
		JR		Z,L91F1
		JR		L921B
L9200:	CALL	C8D18
		LD		A,L
		AND		$07
		CP		A,(IY+$10)
		JR		Z,L9200
		JR		L921B
L920D:	LD		A,(IY+$10)
		SUB		$02
		JR		L9219
L9214:	LD		A,(IY+$10)
		ADD		A,$02
L9219:	AND		$07
L921B:	LD		(IY+$10),A
		RET
L921F:	LD		A,(IY+$10)
		ADD		A,$04
		JR		L9219
ObjFn33:	CALL	C9319
		CALL	C9269
		LD		A,$18
		CP		D
		JR		C,L923F
		CP		E
		JP		C,L923F
		LD		A,C
		CALL	LookupDir
		LD		(IY+$10),A
		JP		L9149
L923F:	CALL	C92CF
		JP		C92B7
L9245:	CALL	C9269
		LD		A,D
		CP		E
		LD		B,$F3
		JR		C,L9251
		LD		A,E
		LD		B,$FC
L9251:	AND		A
		LD		A,B
		JR		NZ,L9257
		XOR		$0F
L9257:	OR		C
L9258:	CALL	LookupDir
		JR		L921B
L925D:	CALL	C9269
		XOR		$0F
		JR		L9258
L9264:	CALL	C9269
		JR		L9258
C9269:	CALL	GetCharObj
		LD		DE,L0005
		ADD		HL,DE
		LD		A,(HL)
		INC		HL
		LD		H,(HL)
		LD		L,A
		LD		C,$FF
		LD		A,H
		SUB		(IY+$06)
		LD		D,A
		JR		Z,L928A
		JR		NC,L9283
		NEG
		LD		D,A
		SCF
L9283:	PUSH	AF
		RL		C
		POP		AF
		CCF
		RL		C
L928A:	LD		A,(IY+$05)
		SUB		L
		LD		E,A
		JR		Z,L92A0
		JR		NC,L9297
		NEG
		LD		E,A
		SCF
L9297:	PUSH	AF
		RL		C
		POP		AF
		CCF
		RL		C
		LD		A,C
		RET
L92A0:	RLC		C
		RLC		C
		LD		A,C
		RET
C92A6:	LD		A,(L8ED8)
		BIT		0,A
		RET		NZ
		OR		$01
		LD		(L8ED8),A
		LD		HL,(CurrObject)
		JP		CA05D
C92B7:	LD		(IY+$0C),$FF
		LD		A,(L8ED8)
		AND		A
		RET		Z
		CALL	C92A6
		LD		HL,(CurrObject)
		CALL	CB0BE
		LD		HL,(CurrObject)
		JP		CA0A5
C92CF:	CALL	C937E
C92D2:	CALL	C82C9
		RET		NC
C92D6:	LD		A,(L8ED8)
		OR		$02
		LD		(L8ED8),A
		RET
C92DF:	AND		A,(IY+$0C)
		CP		$FF
		LD		(L8ED9),A
		RET		Z
		CALL	LookupDir
		CP		$FF
		LD		(L8ED9),A
		RET		Z
		PUSH	AF
		LD		(L8ED9),A
		CALL	C8FC0
		POP		BC
		CCF
		JP		NC,L930F
		PUSH	AF
		CP		B
		JR		NZ,L9306
		LD		A,$FF
		LD		(L8ED9),A
L9306:	CALL	C92A6
		POP		AF
		CALL	C8CD3
		SCF
		RET
L930F:	LD		A,(L822D)
		INC		A
		RET		Z
C9314:	LD		A,$06
		JP		CharThing11
C9319:	BIT		4,(IY+$0C)
		JR		Z,L9354
C931F:	LD		HL,(CurrObject)
		CALL	CAB06
		JR		NC,L933D
		CCF
		JR		NZ,L9331
		BIT		4,(IY+$0C)
		RET		NZ
		JR		L9354
L9331:	BIT		4,(IY+$0C)
		SCF
		JR		NZ,L933D
		RES		4,(IY+$0B)
		RET
L933D:	PUSH	AF
		CALL	C92A6
		RES		5,(IY+$0B)
		INC		(IY+$07)
		LD		A,$03
		CALL	CharThing11
		POP		AF
		RET		C
		INC		(IY+$07)
		SCF
		RET
L9354:	LD		HL,(CurrObject)
		CALL	CAC41
		RES		4,(IY+$0B)
		JR		NC,L9362
		CCF
		RET		Z
L9362:	CALL	C92A6
		DEC		(IY+$07)
		SCF
		RET
C936A:	LD		A,(IY+$10)
		ADD		A,$76
		LD		L,A
		ADC		A,$93
		SUB		L
		LD		H,A
		LD		A,(HL)
		RET