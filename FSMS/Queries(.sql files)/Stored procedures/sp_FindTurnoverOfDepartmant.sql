Create Procedure sp_FindTurnoverOfDepartmant @StartDate smalldatetime, @EndDate smalldatetime, @depNo int
As
Begin
  Declare @Result decimal(15,2)
  Set @Result = (Select SUM(s.TotalPrice)
                 From Sale s inner join Product p on s.Barcode = p.Barcode
                 Where @StartDate <= s.SaleDate and s.SaleDate <= @EndDate and p.RelatedDepartmentNo = @depNo) 

  Select (isnull(@result,0)) "Bölümün Cirosu"
End

exec sp_FindTurnoverOfDepartmant  '2021-12-03', '2021-12-13', 1001