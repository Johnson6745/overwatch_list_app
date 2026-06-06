# Overwatch List App

Mobilna aplikacja Flutter do przeglądania postaci i map z gry Overwatch.

## Funkcjonalności

- 📋 **Lista postaci** – przeglądanie wszystkich bohaterów z filtrowaniem po nazwie i roli
- 🗺️ **Lista map** – przeglądanie map z filtrowaniem po nazwie i trybie gry
- ⭐ **Ulubione** – dodawanie postaci i map do ulubionych
- 🔧 **Ustawienia** – zmiana motywu aplikacji oraz ręczne odświeżanie danych z API
- 📴 **Tryb offline** – dane przechowywane lokalnie w Hive

## Technologie

- **Flutter** – framework mobilny
- **Hive** – lokalna baza danych
- **Firebase Analytics** – analityka eventów
- **Firebase Crashlytics** – monitoring błędów
- **OverFast API** – źródło danych o postaciach i mapach

## Motywy

Aplikacja oferuje trzy motywy: Ciemny/Gaming, Jasny/Minimalistyczny oraz Overwatch Orange.

## API

Dane pobierane są z publicznego API:
- `GET https://overfast-api.tekrop.fr/heroes`
- `GET https://overfast-api.tekrop.fr/maps`
