Create Procedure sp_ListPaymentToSuppliersInRange @StartDate smalldatetime , @EndDate smalldatetime
As
Begin
Select s.CompanyCode, s.CompanyName, s.City, derTab.TotalPayment
From Supplier s inner join (Select p.SupplierCode, SUM(p.TotalPrice) TotalPayment
                            From Purchase p
							Where @StartDate <= p.PurchaseDate and p.PurchaseDate <= @EndDate
                            Group By p.SupplierCode) derTab
				on s.CompanyCode = derTab.SupplierCode
End

exec sp_ListPaymentToSuppliersInRange '2021-12-05', '2021-12-15'

