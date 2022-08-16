# Location-Station

In der App "Location Station" soll mit wenigen Touches eine Anzeige der Abfahrten des ÖPNVs in der
Nähe des Nutzers möglich sein.

Nach Öffnung der App werden folgende Daten direkt auf der eingebundenen Karte angezeigt:
- Der aktuelle ermittelte Standort des Nutzers
- Haltestellen, die sich in der Nähe vom Nutzer befinden (Umkreis x)
- Abfahrtszeiten des ÖPNVs an der Haltestelle

Außerdem gibt es noch einen weiteren Refresh Button, der die Daten aktualisiert.


**Start:**
Nach öffnen der App wird die Karte mit den Standorten (Nutzer + Haltestellen in der Umgebung)
angezeigt. Der Refresh Button befindet sich unten in der View.

**Abfahrten:**
Nachdem man eine Haltestelle ausgewählt hat, werden die aktuellen Abfahrtszeiten aller ÖPNVs an
der Haltestelle aufgelistet. Mit den Button „Show More“ können spätere Anfahrten angezeigt
werden.

**Wie kann man die App laufen:**
- 1. Clonen
- 2. Location-Station/LocationStation/LocationStation.xcodeproj in Xcode aufmachen
- 3. App Bauen oder einfach starten mit den Play Button
