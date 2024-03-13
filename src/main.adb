with Ada.Text_IO;

procedure Main is

   Can_Stop : Boolean := False;
   pragma Volatile(Can_Stop);

   Thread_Amount : Natural := 2;
   Sum : Long_Long_Integer := 0;
   pragma Volatile(Sum);
   
   task type Break_Thread;
   task type Main_Thread is
      entry Start(Thread_Id: Integer; Step: Integer);
      end Main_Thread;

   task body Break_Thread is
   begin
      delay 4.0;
      Can_Stop := True;
   end Break_Thread;

   task body Main_Thread is
      My_Id: Integer;
      My_Step: Integer;
   begin
      accept Start(Thread_Id: Integer; Step: Integer) do
         My_Id := Thread_Id;
         My_Step := Step;
      end Start;
      loop
         delay 1.0;
         Sum := Sum + 1;
         exit when Can_Stop;
      end loop;

      Ada.Text_IO.Put_Line("Thread " & My_Id'Img & " " & "Sum: " & Sum'Img);
   end Main_Thread;

   B1 : Break_Thread;
   T : array(1 .. Thread_Amount) of Main_Thread;
begin
   for I in 1..Thread_Amount loop
      T(I).Start(Thread_ID => I,Step => I+1);
   end loop;
end Main;
