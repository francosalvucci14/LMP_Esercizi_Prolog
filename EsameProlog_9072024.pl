% Regole per tradurre le frasi in forma canonica
traduci_frase('Il cavallo si nutre di biada.', mangia(cavallo, biada)).
traduci_frase('Il cibo del cavallo è la biada.', mangia(cavallo, biada)).
traduci_frase('Il cavallo mangia la biada.', mangia(cavallo, biada)).
traduci_frase('Il ragno si nutre di rosmarino.', mangia(ragno, rosmarino)).
traduci_frase('Il leone si nutre del cavallo.', mangia(leone, cavallo)).
traduci_frase('L\'aquila si nutre del ragno.', mangia(aquila, ragno)).
traduci_frase('Il lupo si nutre del leone.', mangia(lupo, leone)).
traduci_frase('L\'orso si nutre del lupo.', mangia(orso, lupo)).
traduci_frase('Il serpente si nutre del rosmarino.', mangia(serpente, rosmarino)).
traduci_frase('L\'aquila mangia il serpente.', mangia(aquila, serpente)).
traduci_frase('Il falco si nutre dell\'aquila.', mangia(falco, aquila)).

% Predicato per aggiungere le relazioni alla base di conoscenza
aggiungi_relazione(Frase) :-
    traduci_frase(Frase, Relazione),
    assert(Relazione).

% Propagazione dell'inquinamento attraverso la rete
propaga_inquinamento(Specie, Distanza, Inquinamento) :-
    Inquinamento is 0.87 ^ Distanza,
    write(Specie), write(' è inquinato con livello: '), write(Inquinamento), nl,
    setof(Preda, mangia(Specie, Preda), Prede),
    propaga_inquinamento_prede(Prede, Distanza).

propaga_inquinamento_prede([], _).
propaga_inquinamento_prede([Preda|Rest], Distanza) :-
    Distanza1 is Distanza + 1,
    propaga_inquinamento(Preda, Distanza1, _),
    propaga_inquinamento_prede(Rest, Distanza).

% Esegui la propagazione dell'inquinamento da una specie iniziale
propaga_inquinamento_da(Specie) :-
    propaga_inquinamento(Specie, 0, _).

% Esempio di utilizzo
%:- aggiungi_relazione('Il cavallo si nutre di biada.').
%:- aggiungi_relazione('Il cavallo mangia la biada.').
%:- aggiungi_relazione('Il ragno si nutre di rosmarino.').
%:- aggiungi_relazione('Il cibo del cavallo è la biada.').
%:- aggiungi_relazione('Il leone si nutre del cavallo.').
%:- aggiungi_relazione('L\'aquila si nutre del ragno.').
%:- aggiungi_relazione('Il lupo si nutre del leone.').
%:- aggiungi_relazione('L\'orso si nutre del lupo.').
%:- aggiungi_relazione('Il serpente si nutre del rosmarino.').
%:- aggiungi_relazione('L\'aquila mangia il serpente.').
%:- aggiungi_relazione('Il falco si nutre dell\'aquila.').

% Avvia la propagazione dell'inquinamento dal cavallo
%:- propaga_inquinamento_da(cavallo).