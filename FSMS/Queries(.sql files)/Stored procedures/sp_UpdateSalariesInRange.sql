Create Procedure sp_UpdateSalariesInRange @LowerLimit Decimal(9,2) , @UpperLimit Decimal(9,2),  @NewSalary Decimal(9,2)
As
Begin
  Update e
  Set e.Salary = @NewSalary
  From Employee e
  Where @LowerLimit <= e.Salary and e.Salary <= @UpperLimit 
End

Select * From Employee
exec sp_UpdateSalariesInRange 4200, 4300, 4350.50
Select * From Employee