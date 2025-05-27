# Versione dell'IDE: RARS 1.6
# instret circa 3000/3100
#------------------------------------------------------------------------------------------------------
#Autore: Leonardo Fassari
#Ultima Modifica: 11/05/2025
#Tempo Totale: 8 ore circa
#Obiettivi futuri:
# * Aggiungere i controlli dell'input [fatto]
# * Aggiungere i controlli della vittoria del giocatore (Tris eseguito) e dire quale giocatore ha vinto [fatto]
# * Obiettivo complesso, aggiungere una funzione che permatta all'utente di giocare contro un bot [Pseudo-fatto]
#------------------------------------------------------------------------------------------------------

.global main

.data
	MatTris: .word 32:9
	Rig_col: .word 3, 3	# Logica tris
	
	
	mess_start: .asciz "By Leonardo Fassari programmed with RISC-V \nO-|  Benvenuto al____Gioco del Tris!!____  |-O"
	mess_1: .asciz " -> ERROR |Caro utente, ha inavvertitamente premuto un tasto non ammesso al momento! RIPROVA!\n\n"
	mess_1_i: .asciz " -> I tasti ammessi al momento sono:\n r | 0 -> per far occupare una casella in modo random (da player_1 o player_2), dipende dal turno in cui viene utilizzata\n q | 7 -> prima casella in alto a sinistra (prima colonna della prima riga)\n w | 8 -> seconda colonna della prima riga\n e | 9 -> terza colonna della prima riga\n a | 4 -> prima colonna della seconda riga\n s | 5 -> seconda colonna della seconda riga\n d | 6 -> terza colonna della seconda riga\n z | 1 -> prima colonna della terza riga\n x | 2 -> seconda colonna della terza riga\n c | 3 -> terza colonna della terza riga\n \n\n"
	mess_2: .asciz " -> error |Caro utente, la casella scelta è già occupata! RIPROVA!\n\n"
	mess_2_i: .asciz " -> Nel Tris non è possibile occupare una casella già occupata! \n\n"
	mess_3:	.asciz " Player_1 ! Game: \n]"
	mess_4: .asciz " Player_2 | Game: \n]"
	mess_5: .asciz " PLAYER_1 WIN! "
	mess_6: .asciz " PLAYER_2 WIN! "
	mess_7: .asciz " PAREGGIO! "
	
	# dec: 79 -> ASCII: o
	# dec: 88 -> ASCII: x

.text
#--------------------------------------------------------------------------------------------------------------------//MAIN
	main:
	
	#Musica e inizio
	# Start Message
	li a7, 4
	la a0, mess_start
	ecall
	# Mmmuseca!
	li a7, 33		# syscall ID per MidiOutSync
	#
	li a2, 119         	# strumento
	
	li a1, 800         	# durata in ms
	li a3, 100
	
	li a0, 61
	ecall
	
	li a2, 116
	ecall
	
	# Chiamata alla funziona Draw, disegna la matrice con casella del Tris
	la s0, MatTris	# Passo l'indirizzo base della Matrice che voglio visualizzare nella tabella del Tris
	li t0, 8
	
	# Disegno la matrice vuota (tabella iniziale)
	mv a0, s0
	jal Draw_Mat	# Salto alla funzione
		
	for_main: bltz t0, end_forMain
	
		# Gestione inserimento
		mv a0, s0
		mv a1, t0
		jal Insert_Elem		# Ci passo t0
		
		# Stampa
		mv a0, s0
		jal Draw_Mat	# Salto alla funzione
		
		# Restituisce 1 in a0 se c'è un Tris
		mv a0, s0
		jal who_win
		
		bnez a0, end_forMain_xTRIS	# Si è verificato un Tris
		
		
		
	#-----------
	addi t0, t0, -1
	j for_main
	end_forMain:
		li a7, 4
		la a0, mess_7
		ecall
	j end_program

	end_forMain_xTRIS:
		li a7, 4
		
		li t2, 2
		rem t0, t0, t2
		beqz t0, TRIS_Player_1
			la a0, mess_6
		j print_whoWin
		TRIS_Player_1:
			la a0, mess_5
		print_whoWin:
		ecall
		
		# Mmmuseca!
		li a7, 33		# syscall ID per MidiOutSync
		#
		li a2, 16         	# strumento
		
		li a1, 800         	# durata in ms
		li a3, 100
		
		li a0, 60
		ecall
		
		li a0, 62
		ecall
		
		li a0, 65
		ecall
		
		li a0, 67
		ecall
		
	
	end_program:
	#fine del progamma
	li a7, 10
	ecall

#____________________________________________________________________________________________________________________//


# Funzioni


Draw_Mat:
	addi sp, sp -12
	sw ra, 8(sp)
	sw a0, 0(sp)
	mv s0, a0
	sw t0, 4(sp)
	#_____________
	# Funzione di disegno
	
	# Draw "\n", vado a capo
	li a7, 11
	li a0, 10
	ecall
	
	la t1, Rig_col
	lw t0, 0(t1)		# Lo usiamo per le righe (num righe)
	lw t1, 4(t1)		# Lo usiamo per le colonne (num colonne)
	#
	for_riga: blez t0, end_forRiga
		mv a0, s0
		
		li t3, 1	# Mi serve per decidere quando stampare '|'
		#reg di appoggio
		mv t2, t1
		for_colonna: blez t2, end_forColonna
			# Draw elementi
			li a7, 4	# test
			mv a0, s0
			ecall
			addi s0, s0, 4
			
			
			if: ble t2, t3, end_if
				li a7, 11
				li a0, '|'
				ecall	
			end_if:
		
		#----------
		#contatore:
		addi t2, t2, -1
		j for_colonna
		end_forColonna:
		
		# Draw "\n", vado a capo
		li a7, 11
		li a0, 10
		ecall
		
		slli t4, t1, 1
		addi t4, t4, -1
		mv t5, t0
		addi t5, t5, -1
		ciclo_sep_oriz: 
		blez t4, end_ciclo_sep
		beqz t5, end_ciclo_sep
			# a7 è già uguale a 11
			li a0, '-'
			ecall
			addi t4, t4, -1
			
			if_caracter: beqz t4, end_ifCaracter
				li a0, '|'
				ecall
				addi t4, t4, -1
			end_ifCaracter:
			
		#-------------
		j ciclo_sep_oriz
		end_ciclo_sep:
		
		# Draw "\n", vado a capo
		li a7, 11
		li a0, 10
		ecall
		
	
	#----------
	#contatore:
	addi t0, t0, -1
	j for_riga
	end_forRiga:
	
	
	#_____________
	lw s0, 0(sp)
	lw t0, 4(sp)
	lw ra, 8(sp)
	addi sp, sp +12
	
	ret
#________________________________________________________________
#################################################################

Insert_Elem:
addi sp, sp, -12
sw ra, 8(sp)
sw a0, 4(sp)
sw a1, 0(sp)

mv s0, a0
mv t0, a1
#__________

li t2, 2
li t3, 0
rem t0, t0, t2

# Inserimento carattere (X/O)
inserimento_pos_casella:
	# A chi tocca?
	li a7, 4
	beqz t0, player_1
		la a0, mess_4
		li t5, 65

	j end_wich_player
	player_1:
		la a0, mess_3
		li t5, 67

	end_wich_player:
	ecall
	
	# Mini sleep
	li a7, 32
	li a0, 250
	# Mmmuseca!
	li a7, 33		# syscall ID per MidiOutSync
	#
	li a2, 88         	# strumento
	li a1, 350         	# durata in ms
	mv a0, t5
	ecall
	
	# Inserimento scelta | Casella del Tris
	li a7, 12
	ecall
	
	# Dove deve essere inserito

	switch:
		
		# Modifica input in caso di scelta di r (valore pseudorandom)
		# if: 0/r
		li t1, 'r'
		beq   a0, t1, random_0r
		#
		li t1, '0'
		bne  a0, t1, endRandom_0r
			random_0r:
			li a7, 42
			li a0, 0
			li a1, 9
			ecall
			addi a0, a0, 49		# +48 per convertirlo in un valore della tabella ASCII e aggiungo uno perché voglio i valori da 1 a 9 e non da 0
			li t3, 1
		endRandom_0r:
		
		# Case: 7
		li t1, 'q'
		beq   a0, t1, case_7q
		#
		li t1, '7'
		bne  a0, t1, endCase_7
			case_7q:
			addi s0, s0, 0
		j end_switchCase
		endCase_7:
		
		# Case: 8
		li t1, 'w'
		beq  a0, t1, case_8w
		#
		li t1, '8'
		bne a0, t1, endCase_8
			case_8w:
			addi s0, s0, 4
		j end_switchCase
		endCase_8:
		
		# Case: 9
		li t1, 'e'
		beq  a0, t1, case_9e
		#
		li t1, '9'
		bne a0, t1, endCase_9
			case_9e:
			addi s0, s0, 8
		j end_switchCase
		endCase_9:
		
		# Case: 4
		li t1, 'a'
		beq  a0, t1, case_4a
		#
		li t1, '4'
		bne a0, t1, endCase_4
			case_4a:
			addi s0, s0, 12
		j end_switchCase
		endCase_4:
		
		# Case: 5
		li t1, 's'
		beq  a0, t1, case_5s
		#
		li t1, '5'
		bne a0, t1, endCase_5
			case_5s:
			addi s0, s0, 16
		j end_switchCase
		endCase_5:
		
		# Case: 6
		li t1, 'd'
		beq  a0, t1, case_6d
		#
		li t1, '6'
		bne a0, t1, endCase_6
			case_6d:
			addi s0, s0, 20
		j end_switchCase
		endCase_6:
		
		# Case: 1
		li t1, 'z'
		beq  a0, t1, case_1z
		#
		li t1, '1'
		bne a0, t1, endCase_1
			case_1z:
			addi s0, s0, 24
		j end_switchCase
		endCase_1:
		
		# Case: 2
		li t1, 'x'
		beq  a0, t1, case_2x
		#
		li t1, '2'
		bne a0, t1, endCase_2
			case_2x:
			addi s0, s0, 28
		j end_switchCase
		endCase_2:
		
		# Case: 3
		li t1, 'c'
		beq  a0, t1, case_3c
		#
		li t1, '3'
		bne a0, t1, endCase_3
			case_3c:
			addi s0, s0, 32
		j end_switchCase
		endCase_3:
		
		li t1, 0
		
	end_switchCase:
	
	# Controllo | tasto non ammesso
	#if:
	bnez t1, end_Contr_Tasti_Ammessi
		# Messaggio di avviso
		li a7, 55
		la a0, mess_1
		li a1, 2
		ecall
		# Messaggio di info
		li a7, 55
		la a0, mess_1_i
		li a1, 3
		ecall
		# Andiamo a capo
		li a7, 11
		li a0, '\n'
		ecall
		j inserimento_pos_casella
	#--------------------------------
	end_Contr_Tasti_Ammessi:
	
	# Controllo occupazione
	lw t2, 0(s0)
	li t1, 32
	beq t2, t1, end_Contr_Occupation
		lw a0, 4(sp)
		mv s0, a0
		
		beqz t3, end_casualOccp
			# In caso la casella sia stata impostata in modo random
			li a0, 'r'
			li t3, 0
			
		j switch
		end_casualOccp:
		
		# In caso la casella sia stata impostata dall'utente
		# Messaggio di avviso
		li a7, 55
		la a0, mess_2
		li a1, 2
		ecall
		# Messaggio di info
		li a7, 55
		la a0, mess_2_i
		li a1, 3
		ecall
		# Andiamo a capo
		li a7, 11
		li a0, '\n'
		ecall
		j inserimento_pos_casella
		
	end_Contr_Occupation:
	#---------------------
	
	# t0 contiene dall'inizio della funzione il modulo tra i cicli mancanti e 2
	# Quindi una volta conterrà un numero positivo e nella volta successiva un numero negativo, alternandoli
	#----
	if_x: beqz t0, else_o
		li a0, 'o'
	j end_sel_x_o
	#
	else_o:
		li a0, 'x'
	j end_sel_x_o
	end_sel_x_o:
	#----
	sw a0, 0(s0)
	
	#---------- Aggiunta di un '\n' alla fine
	li a7, 11
	li a0, '\n'
	ecall
		
	# Cosa deve essere inserito?
		
#__________
lw t0, 0(sp)
lw s0, 4(sp)
lw ra, 8(sp)
addi sp, sp, +8

ret
#________________________________________________________________
#################################################################

who_win:
addi sp, sp, -8
sw ra, 0(sp)
sw a0, 4(sp)

mv s0, a0
mv t2, s0
#--------------

	# Case Tris su colonna
	li t3, 3
	li t4, 0	# La tatto come bool -> Diventa 1, ovvero vera se c'è un Tris
	for_xColonna_Tris:	beqz t3, end_for_xColonna_Tris
		lw t5, 0(t2)
		li t6, 32
		
		#if L'elemento della prima riga della colonna non e' blank
		beq t5, t6, Col_blank_noTris
			lw t6, 12(t2) 
			#if
			bne t5, t6, Col_notEqual_noTris
				lw t5, 24(t2)
				bne t5, t6, Col_notEqual_noTris
					li t4, 1
					j end_for_xColonna_Tris
			Col_notEqual_noTris:
		Col_blank_noTris:
		
	#----
	addi t2, t2, 4
	addi t3, t3, -1
	j for_xColonna_Tris
	
end_for_xColonna_Tris:
#-------------------------
bnez t4, end_verificaTris

	# Case Tris su riga__________________________________________________________
	mv t2, s0
	li t3, 3
	li t4, 0	# La tatto come bool -> Diventa 1, ovvero vera se c'è un Tris
	for_xRiga_Tris:	beqz t3, end_for_xRiga_Tris
		lw t5, 0(t2)
		li t6, 32
		
		#if L'elemento della prima riga della colonna non e' blank
		beq t5, t6, Rig_blank_noTris
			lw t6, 4(t2) 
			#if
			bne t5, t6, Rig_notEqual_noTris
				lw t5, 8(t2)
				bne t5, t6, Rig_notEqual_noTris
					li t4, 1
					j end_for_xRiga_Tris
			Rig_notEqual_noTris:
		Rig_blank_noTris:
		
	#----
	addi t2, t2, 12
	addi t3, t3, -1
	j for_xRiga_Tris
	
end_for_xRiga_Tris:
	
bnez t4, end_verificaTris
	
	# Case Tris su diagonale__________________________________________________________
	mv t2, s0
	li t3, 1
	li t4, 0	# La tatto come bool -> Diventa 1, ovvero vera se c'è un Tris
	for_xDiag_Tris:	bltz t3, end_for_xDiag_Tris
		lw t5, 0(t2)
		li t6, 32
		
		#if L'elemento della prima riga della colonna non e' blank
		beq t5, t6, Diag_blank_noTris
			#if: controllo nel primo ciclo la diagonale sxdx
			beqz t3, diag_dxsx
				lw t6, 16(t2) 
				#if
				bne t5, t6, Diag_notEqual_noTris
					lw t5, 32(t2)
					bne t5, t6, Diag_notEqual_noTris
						li t4, 1
			j end_for_xDiag_Tris
			#else: mi trovo nella seconda iterazione e quindi controllo la diagonale dxsx	
			diag_dxsx:
				lw t6, 8(t2) 
				#if
				bne t5, t6, Diag_notEqual_noTris
					lw t5, 16(t2)
					bne t5, t6, Diag_notEqual_noTris
						li t4, 1
			j end_for_xDiag_Tris
			
		Diag_notEqual_noTris:	
		Diag_blank_noTris:
		
	#----
	addi t2, t2, 8
	addi t3, t3, -1
	j for_xDiag_Tris
	
end_for_xDiag_Tris:

#--------------
end_verificaTris:
mv a0, t4
#--------------
lw ra, 0(sp)
lw s0, 4(sp)
addi sp, sp, +8
ret
