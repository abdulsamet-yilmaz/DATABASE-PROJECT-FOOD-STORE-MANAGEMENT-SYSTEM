Create Procedure Sp_FindMoneyFlow @StartDate smalldatetime, @EndDate smalldatetime
As
Begin
  Declare @Result1 decimal(15,2)
  Set @Result1 = (Select (SUM(TotalPrice) - SUM(TotalTaxCost))
                       From Sale
                       Where @StartDate <= SaleDate and SaleDate <= @EndDate)
  Declare @Result2 decimal(15,2)
  Set @Result2 = (Select (SUM(TotalTax) - SUM(TotalPrice))
                           From CustomerReturn
                           Where @StartDate <= ReturnDate and ReturnDate <= @EndDate)
  Declare @Result3 decimal(15,2)
  Set @Result3 = (Select Sum(TotalCost)
                           From ProductDestruction
                           Where @StartDate <= DestructionDate and DestructionDate <= @EndDate)
  Declare @Result4 decimal(15,2)
  Set @Result4 = (Select Sum(TotalPrice)
                           From Purchase
                           Where @StartDate <= PurchaseDate and PurchaseDate <= @EndDate)
  Declare @Result5 decimal(15,2)
  Set @Result5 = (Select SUM(TotalPrice)
                           From ReturnToCompany
                           Where @StartDate <= ReturnDate and ReturnDate <= @EndDate)

  Select (isnull(@result1,0) + isnull(@result2,0) - isnull(@result3,0) - isnull(@result4,0) + isnull(@result5,0)) "Para Akýþý"
End

exec Sp_FindMoneyFlow '2021-12-15', '2021-12-18'