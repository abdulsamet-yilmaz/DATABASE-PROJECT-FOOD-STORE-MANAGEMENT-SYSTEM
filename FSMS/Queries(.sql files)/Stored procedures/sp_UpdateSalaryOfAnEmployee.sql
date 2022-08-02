Create Procedure sp_UpdateSalaryOfAnEmployee @EmployeeNo int , @NewSalary Decimal(9,2)
As
Begin
  Update e
  Set e.Salary = @NewSalary
  From Employee e
  Where e.EmployeeNo = @EmployeeNo
End

