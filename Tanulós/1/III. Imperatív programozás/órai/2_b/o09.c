#include <stdio.h>

int main(){
    // Egész típusok között egyszerű másolás történik, előjeles és nem előjeles között ha előjelesőből megyünk nem előjelesbe akkor pozitív számok maradnak változatlanok,
    // negatív számok pedig egy a nem előjeles tartományba fognak esni. Nem előjelesből megyünk előjelesbe akkor pozitív számok maradnak az előjeles maximális értékéig,
    // a túl nagy pozitív számok meg negatív számmá alakulnak. A bool és char egész szám típusként értelmezhetőek.
    // Egyészből lebegő pontosba történő átjárás mind a két irányba működik csak a számok lebegő pontos része elveszik kerekítés nélkül.
    // Lebegő pontos típusok között az átjárás során csökken a pontosság
}