-- Lấy thông tin về Mã đơn hàng, mã sản phẩm, mã khách hàng, số lượng sản phẩm của những dòng dữ liệu thỏa điều kiện Ship Mode là Standard Class
USE HAN_PORTFOLIO
SELECT Order_ID, Product_ID, Customer_ID, Quantity
FROM sales
WHERE Ship_Mode = 'Standard Class'
-- Lấy thông tin về mã đơn hàng thỏa mãn điều kiện có tồn tại một loại sản phẩm (Product ID) thuộc nhóm category là Office Supplies và có quantity > 3
SELECT Order_ID, Category, Quantity
FROM sales
WHERE Category = 'Office Supplies' and Quantity > 3
-- Thống kê số lượng mã đơn hàng, số lượng các loại sản phẩm (product ID), tổng doanh thu và tổng lợi nhuận theo từng Category, sắp xếp theo thứ tự giảm dần của doanh thu
SELECT COUNT(Order_ID) as So_luong_don_hang, COUNT(Product_ID) as So_luong_san_pham, SUM(Sales) as Tong_doanh_thu, SUM(Profit) as Tong_loi_nhuan
FROM sales
GROUP BY Category
ORDER BY Sum(Sales) DESC
-- Với mỗi loại Ship mode, lấy ra thông tin khách hàng (Customer ID), số lượng đơn hàng sao cho có số lượng đơn hàng theo hình thức Ship mode đó là nhiều nhất
select Ship_Mode, customer_id, count(customer_id) as total_order
from sales
group by Ship_mode, customer_id
having count(customer_id) >= all (select count(customer_id)
                                    from sales s1
                                    where sales.ship_mode= s1.ship_Mode
                                    group by Ship_Mode, customer_id)
