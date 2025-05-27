IL MIO PROGETTO VIDEOLUDICO | TRIS ❌ / ⭕ in RISC-V 🕹
L'informatica del passato

Facciamo un passo nel passato{
  🖋️ C’erano una volta… le schede perforate 📇🎟️
  Negli anni ‘60 e ‘70, prima che nascessero le moderne interfacce grafiche e i linguaggi ad alto livello, i computer venivano programmati con schede perforate, conosciute anche come schede Hollerith o schede di archiviazione dati.
  📄 Si tratta di schede di cartoncino rigido, divise in 80 colonne, ognuna delle contiene 2 righe di 40 caratteri,
  capaci di contenere informazioni binarie:
  1 o 0, ovvero foro o assenza di foro.
  Ogni colonna è composta da 2 bit, ovvero una coppia di valori che potevano acquisire come valori ZERO o UNO, poiché i computer sono in grado di ragionare distinguendo solo due valori!
  💡 Esempio semplice
  Prendiamo questa frase:
  “Sta passando la corrente in questo istante”
  - Se in questo istante la corrente passa -> allora assumiamo che la frase sia vera -> true
  - Se in questo istante la corrente NON passa -> allora assumiamo che la frase sia falsa-> false
  E dunque perché zeri e uni?
  
  1 corrisponde a true e 0 corrisponde a false!
  Ecco spiegato perché si parla di bit (binary digit), e perché tutta la logica informatica si fonda su questa distinzione fondamentale: on/off, vero/falso, 1/0.
  Proprio al livello elettronico corrispondo a passaggi o non passaggi della corrente elettrica! scheda 
  
  🛠️ Ma a cosa servivano davvero?
   Le schede perforate venivano usate per istruire il computer su cosa fare:
   ogni scheda rappresentava un insieme di comandi da eseguire, oppure dati da elaborare.
   Immagina di dover dare al computer una ricetta: ogni scheda era come un ingrediente o un passo della preparazione.
  Più schede = un intero programma.
  Erano usate in università🏫, enti pubblici🏛, banche🏦, e grandi aziende🏢 per eseguire calcoli, stampare documenti, elaborare stipendi o archiviare dati.
  
}
Arriviamo a parlare del mio progetto{
  Ma da lì in poi è stato un lungo viaggio! 🛣️
  Siamo passati dalla programmazione in linguaggio macchina, fatta solo di 0️⃣ e 1️⃣ incomprensibili all’occhio umano,
  al linguaggio Assembly (con comandi come: mv, la, add, sub, slli…),
  un modo più “umano” di parlare con il processore, anche se ancora molto vicino 🖥️ all’hardware. 💻
  Permetteva di programmare in meno tempo ma bisognava essere ancora esperti per farlo.
  Quando si guida un automobile 🏎️ non abbiamo bisogno di sapere, o almeno in modo completo il funzionamento, del motore, del differenziale ⚙️, della centralina 🚗 e.c.c.
  Possiamo guidare senza preoccuparci di come è composta l'automobile.
  Al giorno d'oggi è possibile programmare ⌨️ senza conoscere l'architettura del Computer, per esempio grazie a linguaggi come Python che semplificano il tutto autogestendo molte cose. 
  
  Ogni processore ha il suo Assembly specifico
  (una lista di comandi e di calcoli che può fare ben definita), 
  pensato per comunicare direttamente con la sua architettura interna.
  💾 Ad esempio, il celebre Intel 8086, simbolo degli anni ’80, usava il proprio Assembly per gestire registri, memoria e salti condizionali con estrema precisione.
  
  In quegli anni la memoria di massa iniziava a liberarsi dai cartoncini perforati, e i dati trovavano casa su Floppy Disk e Hard Disk.
  
  📍 È proprio in questo affascinante contesto che nasce il mio mini-progetto:
  👉🏻 Un gioco del TRIS X/O 
  sviluppato in linguaggio Assembly per architettura RISC-V!
  Con tanto di musiche
  
  Piccola spiegazione:
  Nella prima immagine avete la possibilità di vedere solamente una parte della funzione che ha come obiettivo capire quando c'è un TRIS e chi lo ha eseguito
  La parte che vedete da riga 481 a 508, quella è l'inizio di questa funziona
  In riga 481 c'è l'etichetta che permette di eseguire le istruzioni della funzione, facendo un salto dalla riga da cui viene chiamata fino all'etichetta richiesta e dunque "richiamare" la funzione.
  Da riga 482 fino alla 484, si tiene memoria di alcuni registri (In un linguaggio moderno le chiameremmo variabili) nello stack detto "pila", è una struttura dati a pila, (un elemento sotto l'altro), l'elemento più vecchio è il primo in alto nella pila, quello più recente invece è l'ultimo in basso
  Questo perché i registri sono limitati e vengono utilizzati nella funzione e cambieranno il loro valore nel tempo dunque (deciso da me), avrò così la possibilità, alla fine della funzione o dove ne ho bisogno, di inserire il dato che c'era in origine
  Riga 486/487 copio il valore che contiene a0 nei registri s0 e t2
  
  TUTTO IL RESTO DELLA FRAZIONE DI CODICE CHE VEDETE HA L'OBIETTIVO DI COMPRENDERE SOLAMENTE SE C'E' STATO UN TRIS LUNGO UNA DELLA VARIE COLONNE
  
  [ci sono altri due pezzi molto simili per capire se c'è stato un Tris su una delle righe o una delle diagonali]
  
  ![image](https://github.com/user-attachments/assets/459135a9-6342-4904-b340-ef4cc2e277e3)
  ![image](https://github.com/user-attachments/assets/3bb1213e-c211-4892-bcd2-0f67cc231853)
  ![image](https://github.com/user-attachments/assets/dcc97d2f-5a38-456c-a2c3-4dcb26f0a9f7)
  
}
