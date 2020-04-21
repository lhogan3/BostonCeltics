# BostonCeltics
An iOS application created for CS295 - Mobile Application Development II at the University of Vermont. This application makes use of a Master-Detail structure. The Master View being the list of current players on the roster (as of 4/20/2020) as well as any user-created players. The Detail View shows different pieces of information about the player selected from the Master View, with the option to edit the player or delete the player entirely.
## Technical Features
* **UITableView:** 2 prototype cells; both with different styling. 
* **UINavigationController:** Manages transitions between views.
* **Master-Detail Interface:** Datail interface uses multiple UIStackViews to organize layout.
* **Editable and Safe:** User can edit and delete items, after user is prompted to confirm deletion.
* **Master View Editing Capabilities:** Edit and add Players with "+" and "Edit" buttons in a UINavigationBar
* **Delete from Detail View:** User can delete Player from within detail view with a trash can button in a UIToolBar.
* **Archiving:** Data is saved upon exiting, so it can be viewed between invocations of the app.
## 
