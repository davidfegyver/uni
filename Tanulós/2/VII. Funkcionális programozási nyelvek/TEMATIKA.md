Tematika
Szekvenciális Erlang alapok:

Funkcionális programozás ismertető, Erlang specifikus elemek, nyelvfejlődés
Az Erlang VM
A funkcionális szemlélet bemutatása Erlang nyelvi elemeken keresztül: termek, változók, mintaillesztés, függvények, rekurzió, magasabbrendűség, lambdák.
Listák és listagenerátorok, Binárisok és generátorai
Feltételes vezérlési elemek, hibakezelés, rekordok, makrók.
A dinamikusan típusos programozási nyelvek előnyei, az Erlang dinamikus hívásai
Típus specifikációk
 

Konkurens/párhuzamos Erlang alapok:

Aktor modell:  Erlang processzek és kommunikáció
Új processzek létrehozása, monitorozása, regisztrálása, üzenet küldés-fogadás
Alternatív kommunikációs csatornák: process registry, ETS -- match specification
Hibák detektálása és kezelés, monitorozás, felügyelés
Szekvenciális számítások párhuzamosítása
Konkurens alkalmazások tervezése: kliens-szerver, többszereplős, P2P, etc.
Szoftver frissítés élő rendszerekben (software upgrade)
 Elosztott Erlang:

Elosztott Erlang node-ok
Nyelvi elemek és könyvtári támogatás, hibakezelés
Globális és részben globális node-ok
Elosztott kliens-szerver alkalmazás (chat szerver)
Gyakran használt könyvtári elemek (pl. rpc) 
Behaviour:

Elosztott és konkurens programozás mintái (Erlang/OTP design patterns and behaviors)
gen_server: Client-Server -- részletesebb lesz
gen_statem: Finite State Machine - kimarad
gen_evnt: Event handler -- kimarad
Supervisors
Applications 
--------------------------------------------------------------------------------------------------------------------------

További témák:

Release készítés lépései
Rebar
Tesztelés: pl. QuickCheck, EUnit (PropEr, CommonTest)
Profiling, debugging, tracing, code coverage
Other tools
Nyitottság: kapcsolat más programozási nyelven írt szoftverekkel, nifek, portok, soketek
Saját behaviour készítése
Adatbázisok
Web Szerverek
