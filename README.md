# RomanScanner
This script automates cloning hotel room keys in use by a **ROMAN** hotel casino brand.  
**Make sure to edit the script everywhere `pm3` is referenced with the correct path to your pm3 executeable.**

It is designed to control a proxmark3 running on a raspberry pi02w with a headless kali linux build.

The intended usecase of this script is to have ssh running on the pi with
a connected proxmark3 and power supply. This rig is housed inside of something inconspicuous.

Using a mobile device, you would ssh inti the pi, run romanscanner and
when you get close enough to a room key, romanscanner will use the
proxmark to read, crack, and copy the room key's dump to disk and then
also load the key dump into the proxmark3's emulator simulation memory.

You can then either interrupt the script to revert back to scanning
mode, or you can press the side button on the proxmark3 to do the same.

# Example flow
**(device)** -> ssh into pi -> run romanscanner -> scanning mode enabled  
**(flow)** -> get within range to scan a room key -> you now have obtained the key -> pm3 is simulating the key

Essentially, this just automates the scan/copy/crack/clone process
untill a successful scan and clone is obtained.
