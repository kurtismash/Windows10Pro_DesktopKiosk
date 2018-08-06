# Windows 10 Pro Kiosk Mode (For Desktop Applications)
Windows 10 includes a kiosk mode to lock a user account to running one or multiple applications. This mode is available on Enterprise and Education editions of the operating system, but only partially available in the Pro edition; this edition allows for UWP (new Windows apps) kiosks to be made but lacks functionality for the older "desktop" (win32) applications to be used in a kiosk. Using Group Policy on the local machine and some small scripts, a kiosk-like experience can be created for desktop applications.

Windows 10 Pro contains the ability to lock the user to only specified applications. While this blocks desktop applications from running, it does nothing to block the user's ability to use UWP applications (Edge, Mail, Calendar, Store, etc.). However, these new applications are dependent on explorer.exe (the desktop, start menu, taskbar, etc.). Specifying a custom user interface as the application you wish to run has the bonus of also stopping explorer.exe from starting at the same time. The user is unable to start other applications as task manager is disabled.

## Create a new user

- Open Settings
- Go to Accounts
- Select “Family & other people” from the left sidebar
- Add a local account, ‘Kiosk’ as a standard user

## The scripts

 - Download the scripts autoRestart.vbs and autoRestart.bat
 - Save these somewhere the Kiosk account has read access (E.g. `C:\`)
 - Modify the `.vbs` to run the .bat script (Change the path to where you saved it)
 - Modify the `.bat` script to point to the application you want to start

## Apply a group policy object to the user
- Search “mmc.exe” in the start menu
- Open the management console it suggests
- File -> Add/Remove snap-in…
- Select “Group Policy Object Editor” and press “Add”
- Click “Browse” to select who to apply the policy to
- From the Users tab, select the user Kiosk
- Press Finish
- Press OK
- File -> Save-as
- Save it as something easy to understand (e.g. “GPO for Kiosk”)

## Lock down the account with GPO

 - Open the GPO for the new user
 - In the left sidebar, select Administrative Templates -> System
 - Double click “Custom User Interface”
 - Enable this with the radio buttons at the top
 - Enter `wscript C:\autoRestart.vbs` as the interface file name, press Ok
 - Double click the Ctrl+Alt+Del Options folder
 - Enable “Remove Change Password”
 - Enable “Remove Lock Computer”
 - Enable “Remove Task Manager”
 - File -> Save
 - Sign in as Kiosk and test the account is now locked, the GPO won’t take effect until the account is signed out and in again, switching user won’t update the policy
