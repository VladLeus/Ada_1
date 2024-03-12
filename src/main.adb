with Ada.Text_IO;

procedure Main is

   Can_Stop : Boolean := False;
   pragma Atomic(Can_Stop);

   Thread_Amount : Natural := 5;
   Sum : Long_Long_Integer := 0;

   task type Break_Thread;
   task type Main_Thread;

   task body Break_Thread is
   begin
      delay 4.0;
      Can_Stop := True;
   end Break_Thread;

   task body Main_Thread is
   begin
      loop
         delay 1.0;
         Sum := Sum + 1;
         exit when Can_Stop;
      end loop;

      Ada.Text_IO.Put_Line(Sum'Img);
   end Main_Thread;

   B1 : Break_Thread;
   T : array(1 .. Thread_Amount) of Main_Thread;
begin
   null;
end Main;
