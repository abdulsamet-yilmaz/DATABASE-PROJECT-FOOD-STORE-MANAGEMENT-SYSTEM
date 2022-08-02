Create Procedure Sp_FindTurnoverOfStore @StartDate smalldatetime, @EndDate smalldatetime
As
Begin
  Declare @Result decimal(15,2)
  Set @Result = (Select SUM(TotalPrice)
                 From Sale
                 Where @StartDate <= SaleDate and SaleDate <= @EndDate)

  Select(isnull(@result,0)) "Toplam Maðaza Cirosu"
End

exec Sp_FindTurnoverOfStore '2021-12-03', '2021-12-13'