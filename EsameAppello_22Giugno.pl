% Definizione degli ingredienti disponibili in dispensa e frigorifero
ingredienti_in_dispensa([carne, pasta, pomodoro, cipolla, aglio, olio, sale, pepe]).
ingredienti_in_frigorifero([pollo, verdure, latte, uova, formaggio]).

% Definizione dei piatti con gli ingredienti e il tempo di preparazione
piatto(spaghetti, [pasta, pomodoro, aglio, olio, sale, pepe], 30).
piatto(cotoletta, [carne, sale, pepe], 15).
piatto(omelette, [uova, latte, sale, pepe], 50).
% Definire altri piatti...

% Predicato per verificare se un piatto è preparabile con gli ingredienti disponibili
piatto_preparabile(Piatto, IngredientiNecessari) :-
    ingredienti_in_dispensa(Dispensa),
    ingredienti_in_frigorifero(Frigorifero),
    subtract(Dispensa, IngredientiNecessari, NuovaDispensa),
    subtract(Frigorifero, IngredientiNecessari, NuovoFrigorifero),
    length(NuovaDispensa, DispensaRimanente),
    length(NuovoFrigorifero, FrigoriferoRimanente),
    DispensaRimanente >= 0,
    FrigoriferoRimanente >= 0.

% Predicato per suggerire un piatto per oggi
piatto_per_Oggi(TempoMax, NumPersone, NomePiatto, IngredientiConQuantita) :-
    piatto(NomePiatto, IngredientiNecessari, TempoPreparazione),
    TempoPreparazione =< TempoMax,
    piatto_preparabile(NomePiatto, IngredientiNecessari),
    length(IngredientiNecessari, NumIngredienti),
    IngredientiConQuantita = IngredientiNecessari,
    NumPersone > 0.

% Predicato per segnalare la preparazione di un piatto e rimuovere gli ingredienti
ho_preparato(NomePiatto, Ingredienti) :-
    retractall(ingredienti_in_dispensa(_)),
    retractall(ingredienti_in_frigorifero(_)),
    ingredienti_in_dispensa(Dispensa),
    ingredienti_in_frigorifero(Frigorifero),
    subtract(Dispensa, Ingredienti, NuovaDispensa),
    subtract(Frigorifero, Ingredienti, NuovoFrigorifero),
    assertz(ingredienti_in_dispensa(NuovaDispensa)),
    assertz(ingredienti_in_frigorifero(NuovoFrigorifero)).
    
% Inserire _ al posto delle variabili che danno l'errore Singleton per farlo sparire
