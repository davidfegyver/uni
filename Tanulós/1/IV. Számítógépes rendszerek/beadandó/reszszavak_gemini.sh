#!/bin/bash

# Ellenőrizzük, hogy a felhasználó megadott-e pontosan egy paramétert
if [ "$#" -ne 1 ]; then
    echo "Használat: $0 <fájlnév>"
    exit 1
fi

fajlnev="$1"

# Ellenőrizzük, hogy a fájl létezik-e és olvasható-e
if [ ! -r "$fajlnev" ]; then
    echo "Hiba: A(z) '$fajlnev' fájl nem található vagy nem olvasható."
    exit 1
fi

# Beolvassuk a szavakat egy tömbbe.
# A 'grep .' kiszűri az üres sorokat.
# A 'mapfile -t' (vagy 'readarray -t') soronként olvassa be
# a bemenetet a 'szavak' nevű tömbbe, a sortörések nélkül.
mapfile -t szavak < <(grep . "$fajlnev")

# Ha a fájl üres volt (vagy csak üres sorokat tartalmazott)
if [ ${#szavak[@]} -eq 0 ]; then
    echo "A fájl üres vagy nem tartalmaz szavakat."
    exit 0
fi

# Létrehozunk egy asszociatív tömböt a számoláshoz.
# Kulcs: a szó (mint potenciális részszó)
# Érték: ahányszor más szavakban szerepelt
declare -A szamlalo

# Két egymásba ágyazott ciklus: minden szót összehasonlítunk minden szóval
for szo_mint_reszszo in "${szavak[@]}"; do
    
    # Inicializáljuk a számlálót 0-ra (ha még nem létezik)
    # Ez biztosítja, hogy a 0 találatos szavak is bekerüljenek.
    [ -z "${szamlalo[$szo_mint_reszszo]}" ] && szamlalo[$szo_mint_reszszo]=0

    for szo_a_listaban in "${szavak[@]}"; do
        
        # A feltétel:
        # 1. Ne önmagát vizsgáljuk ($szo_mint_reszszo != $szo_a_listaban)
        # 2. Szerepeljen benne ($szo_a_listaban == *$szo_mint_reszszo*)
        if [[ "$szo_mint_reszszo" != "$szo_a_listaban" && "$szo_a_listaban" == *"$szo_mint_reszszo"* ]]; then
            # Növeljük a számlálót
            ((szamlalo["$szo_mint_reszszo"]++))
        fi
    done
done

# --- Kiértékelés ---

# 1. Keressük meg a maximális találati számot
max_szam=0
for szo in "${!szamlalo[@]}"; do
    if (( ${szamlalo[$szo]} > max_szam )); then
        max_szam=${szamlalo[$szo]}
    fi
done

# 2. Gyűjtsük össze a nyertes(eke)t (holtverseny kezelése)
declare -a nyertesek=()
# Csak akkor keressük a nyerteseket, ha van legalább 1 találat
if (( max_szam > 0 )); then
    for szo in "${!szamlalo[@]}"; do
        if (( ${szamlalo[$szo]} == max_szam )); then
            nyertesek+=("$szo")
        fi
    done
fi

# 3. Eredmény kiírása
if (( ${#nyertesek[@]} == 0 )); then
    echo "Egyik szó sem szerepelt egy másik szóban sem részszóként."
elif (( ${#nyertesek[@]} == 1 )); then
    echo "A legtöbb másik szóban szereplő szó: '${nyertesek[0]}' ($max_szam alkalommal)"
else
    echo "Több szó is holtversenyben végzett ($max_szam alkalommal):"
    for szo in "${nyertesek[@]}"; do
        echo "- $szo"
    done
fi