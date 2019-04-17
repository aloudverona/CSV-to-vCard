/* 
 * Easily export VCARD files from a CSV file.
 * Federico Pepe • 17.04.2019
 */
String path;
boolean fileSelected = false;
Table data;
String[] vcard = new String[0];

int startFrom;

void setup () {
  selectInput("Select a file to process:", "fileSelected");
}

void draw() {
  if (fileSelected) {
    data = loadTable(path, "header");

    println("Righe: " + data.getRowCount());
    println("Colonne: " + data.getColumnCount());
    for (int i = 0; i < data.getRowCount(); i++) {
      vcard = append(vcard, 
        "BEGIN:VCARD\n" +
        "VERSION:3.0\n" +
        "N:" + data.getString(i, "Cognome") + ";" + data.getString(i, "Nome") + ";;;\n" +
        "FN:" + data.getString(i, "Nome") + " " + data.getString(i, "Cognome") + "\n" +
        "EMAIL;type=INTERNET;type=HOME;type=pref:" + data.getString(i, "E-Mail") + "\n" +
        "TEL;type=CELL;type=VOICE;type=pref:" + data.getString(i, "Cellulare") + "\n" +
        "END:VCARD"
        );
      saveStrings("contacts/"+data.getString(i, 1) + " " + data.getString(i, 2) + ".vcf", vcard);
      vcard = new String[0];
      //println(data.getString(i, 1));
    }
    exit();
  }
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    path = selection.getAbsolutePath();
    fileSelected = true;
    println("User selected " + selection.getAbsolutePath());
  }
}
