
 *****************C-LAB******************
 **          D I R E C T O R           **
 **  Universal MIDI routing accessory  **
 **  to address the MIDI-outs of       **
 **  C-LAB EXPORT and UNITOR           **
 **  (c) 1989 Gerhard Lengeling        **
 ****************************************

 This accessory is free and may be copied.
 But: Changes are not allowed!

 This accessory should work with all MIDI software which
 uses the standard MIDI-routines of the Atari's operating
 system.
 
 If you experience incompatibility the manufacturer (or
 better, the programmer) of your software needs the 
 following information:
 
 ------------------------------------------------------
 All MIDI output should be done with with the standard
 MIDI-routines of the Atari's operating system:
   Bconout ( 3 , midi_byte );            /* BIOS 3   */
      or
   Midiws ( count , pointer_to_data );   /* XBIOS 12 */
 ------------------------------------------------------

 Thank you!

