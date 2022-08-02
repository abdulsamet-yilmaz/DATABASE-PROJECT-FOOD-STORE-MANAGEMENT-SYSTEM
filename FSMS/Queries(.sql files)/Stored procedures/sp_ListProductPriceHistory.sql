Create Procedure sp_ListProductPriceHistory @Barcode bigint
As
Begin
  Select *
  From ProductPriceHistory ph
  Where ph.Barcode = @Barcode 
  Order by ph.EffectiveDate desc
End

exec sp_ListProductPriceHistory 8691316520843