# SanDisk Windows Diagnose

Dieses Repository stellt ein PowerShell-Diagnoseskript fuer Windows 11 zur Fehlersuche bei einer externen SanDisk Extreme Portable SSD bereit.

Das Skript verwendet ausschliesslich Windows-Bordmittel, installiert keine Zusatzsoftware und uebertraegt keine Daten automatisch.

## Vorbereitung

1. SanDisk SSD direkt an den USB-Anschluss des Computers anschliessen.
2. Ein geeignetes USB-Datenkabel verwenden.
3. Fuer diesen Test keinen USB-Hub, keine Dockingstation und keinen Monitor zwischenschalten.
4. Die SSD waehrend der gesamten Diagnose angeschlossen lassen.

## Download ohne Anmeldung

Die Datei **SanDisk-Diagnose.ps1** in diesem Repository oeffnen und **Download raw file** anklicken.

Direkter Download:
https://raw.githubusercontent.com/thomas682/SanDisk-Windows-Diagnose/main/SanDisk-Diagnose.ps1

Fuer den Download ist keine GitHub-Anmeldung erforderlich.

## Start unter Windows 11

Windows Terminal bzw. PowerShell **als Administrator** oeffnen. In den Ordner mit der heruntergeladenen Datei wechseln und ausfuehren:

    powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\SanDisk-Diagnose.ps1"

Der Parameter `-ExecutionPolicy Bypass` gilt nur fuer diesen gestarteten PowerShell-Prozess und aendert die permanente Windows-Ausfuehrungsrichtlinie nicht.

## Ergebnis und Versand

Auf dem Desktop wird eine Datei mit einem Namen wie

    SanDisk-Diagnose_2026-10-07_20-55-00.txt

erstellt und automatisch im Editor geoeffnet.

Danach erscheint ein Dialog mit der Aufforderung, die Diagnose-Datei **vollstaendig und unveraendert** an **Thomasschatz@live.de** zu senden. Die Datei wird ausserdem im Windows-Explorer markiert.

Bitte zusammen mit der TXT-Datei folgende Nachweise senden:

1. Screenshot Geraete-Manager: USB-Controller vollstaendig aufgeklappt
2. Screenshot Geraete-Manager: Laufwerke mit angeschlossener SanDisk SSD
3. Screenshot Datentraegerverwaltung: vollstaendiges Fenster
4. Screenshot `winver`: Windows-Version und Build
5. Screenshot `msinfo32`: Systemuebersicht mit PC-/Mainboard-Angaben
6. Foto des verwendeten USB-Anschlusses
7. Foto von SSD, Kabel und verwendetem Anschluss

Die SSD soll bei der Erstellung dieser Nachweise angeschlossen bleiben.

## Erfasste technische Informationen

Der Bericht enthaelt Windows-Version/Build, PC- und Mainboard-Modell, BIOS, USB-Controller und USB-Geraete, erkannte Datentraeger, Bus-Typ, Groesse, Partitionierung, Volumes/Dateisysteme sowie vorhandene Windows-Geraetefehler. Eine Kurzauswertung prueft, ob USB-3.x/xHCI erkennbar ist, USB-Datentraeger erkannt werden und eine SanDisk/Extreme SSD gefunden wird.

## Datenschutz

Es erfolgt **kein automatischer Upload und kein automatischer E-Mail-Versand**. Der Bericht verbleibt lokal auf dem Computer, bis der Benutzer ihn selbst versendet. Er kann technische Kennungen wie Geraete-IDs und Seriennummern enthalten und kann vor dem Versand eingesehen werden.

## Technische Einschraenkung

Das Skript kann nicht verlaesslich messen, wie viel Strom der konkrete USB-C-Port liefert. Ein erkannter xHCI-Controller beweist auch nicht automatisch die Eigenschaften jedes einzelnen physischen USB-Anschlusses.
