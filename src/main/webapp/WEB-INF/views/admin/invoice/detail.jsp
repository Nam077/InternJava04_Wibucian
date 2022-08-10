<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN"/>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../includes/hd.jsp"></jsp:include>
<jsp:include page="../includes/header.jsp"></jsp:include>
<jsp:include page="../includes/sidebar1.jsp"></jsp:include>
<jsp:include page="../includes/container.jsp"></jsp:include>


<div class="card mb-5 mb-xl-10" id="kt_profile_details_view">
    <!--begin::Card header-->
    <div class="card-header cursor-pointer">
        <!--begin::Card title-->
        <div class="card-title m-0">
            <h3 class="fw-bold m-0">Order</h3>
        </div>
        <!--end::Card title-->
        <!--begin::Action-->
        <c:if test="${invoice.status != 2}">
            <span class="btn btn-primary align-self-center save-data">Thanh Toán</span>
        </c:if>
        <!--end::Action-->
    </div>
    <!--begin::Card header-->
    <!--begin::Card body-->
    <div class="card-body p-9">
        <!--begin::Wrapper-->
        <div class="card p-9">
            <div hidden class="mb-10">
                <label for="id-invoice" class="required form-label">Id Hoá Đơn</label>
                <input id="id-invoice" type="text" value="${invoice.id}" readonly
                       class="form-control id-invoice form-control-solid"
                       placeholder="Example input"/>
            </div>
            <div class="mb-10">
                <label for="name-employee-invoice" class="required form-label">Nhân viên</label>
                <input data-value="${invoice.employee.name}" id="name-employee-invoice" type="text"
                       value="${invoice.employee.name}" readonly class="form-control form-control-solid"
                       placeholder="Example input"/>
            </div>
            <div class="mb-10 form-inline ">
                <label for="name-customer-invoice" class="required form-label">Tên khách hàng</label>
                <div class="input-group">
                    <input data-value="${invoice.customerName}" id="name-customer-invoice" type="text"
                           value="${invoice.customerName}" class="form-control form-control-solid name-customer-invoice"
                           placeholder="Example input"/>
                    <span class="btn btn-primary align-self-center save-name-invoice">Lưu Tên</span>
                </div>
            </div>
        </div>
        <div class="card mb-5 mb-xl-10">
            <div class="card-header cursor-pointer">
                <!--begin::Card title-->
                <div class="card-title m-0">
                    <h3 class="fw-bold m-0">Danh sách chi tiết hoá đơn</h3>
                </div>
                <!--end::Card title-->
                <!--begin::Action-->
                <c:if test="${invoice.status != 2}">
                    <span class="btn btn-primary align-self-center add-detail">Thêm chi tiết</span>
                </c:if>
                <!--end::Action-->
            </div>
            <!--begin::Card header-->
            <!--begin::Card body-->
            <div class="card-body">
                <!--begin::Wrapper-->
                <div class="mb-10">
                    <table class="table table-responsive table-row-bordered" id="tabel-invoice">
                        <!--begin::Table head-->
                        <thead>
                        <!--begin::Table row-->
                        <tr class="text-start text-muted fw-bold fs-7 text-uppercase gs-0">
                            <th scope="col" class="min-w-100px">Id chi tiết hoá đơn</th>
                            <th scope="col" class="min-w-100px">Tên sản phẩm</th>
                            <th scope="col" class="min-w-100px">Số lượng</th>
                            <th scope="col" class="min-w-100px">Tổng tiền</th>
                            <c:if test="${invoice.status != 2}">
                                <th scope="col" class="min-w-100px">Hành động</th>
                            </c:if>
                        </tr>
                        <!--end::Table row-->
                        </thead>

                        <tbody class="text-gray-600 fw-semibold">
                        <c:forEach items="${invoice.detailInvoices}" var="item">

                            <tr class="text-start id-detail-invoice-${item.id}">
                                <td><p class="id-detail-invoice-table">${item.id}</p></td>
                                <td><p data-price="${item.product.price}" data-id="item.product.id"
                                       class="id-product-tabel">${item.product.productName}</p></td>
                                <td><p class="quantity-table">${item.quantity}</p></td>
                                <td><p data-price="${item.totalMoney}" class="total-money-price">
                                    <fmt:formatNumber pattern="#,###" value="${item.totalMoney}"/> ₫</p></td>
                                <c:if test="${invoice.status != 2}">
                                    <td>
                                <span data-action="${item.id}"
                                      class="btn btn-icon btn-primary btn-edit  btn-sm btn-icon-md btn-circle"
                                      data-toggle="tooltip" data-placement="top" title="Sửa">
                                    <i class="fa fa-edit"></i>
                                </span>
                                        <span data-action="${item.id}"
                                              class="btn btn-icon btn-danger delete-btn btn-sm btn-icon-md btn-circle"
                                              data-toggle="tooltip" data-placement="top" title="Xóa">
                                <i class="fa fa-trash"></i>
                            </span>
                                    </td>
                                </c:if>
                            </tr>
                        </c:forEach>
                        </tbody>
                        <tfoot class="text-start text-muted fw-bold fs-7 text-uppercase gs-0">
                        <tr class="text-start text-muted fw-bold fs-7 text-uppercase gs-0">
                            <th scope="col" class="min-w-100px">Tổng cộng</th>
                            <th scope="col" class="min-w-100px"></th>
                            <th scope="col" class="min-w-100px"></th>
                            <th scope="col" class="min-w-100px"><p data-price="${invoice.totalMoney}" class="total-money-price-end"><fmt:setLocale
                                    value="vi_VN"/>
                                <fmt:formatNumber pattern="#,###" value="${invoice.totalMoney}"/> ₫</p></th>
                        </tr>
                        </tfoot>
                    </table>
                </div>
                <!--end::Wrapper-->
            </div>
        </div>
    </div>
    <div id="modal-edit-detail" class="modal fade" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title"></h3>
                    <!--begin::Close-->
                    <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal"
                         aria-label="Close">
                        <span class="svg-icon svg-icon-1"></span>
                    </div>
                    <!--end::Close-->
                </div>
                <div class="modal-body">
                    <div class="mb-10">
                        <label class="required form-label ">Id Hoá Đơn</label>
                        <input data-action="" readonly type="text"
                               class="form-control form-control-solid id-detail-invoice"/>
                    </div>
                    <div class="mb-10">
                        <label class="required form-label">Tên sản phẩm</label>
                        <input data-action="" readonly type="text"
                               class="form-control form-control-solid id-product-invoice"/>
                    </div>
                    <div class="input-group mb-5">
                        <span class="input-group-text me-2">Số lượng</span>
                        <span class="input-group-text btn  btn-light-secondary btn-outline text-center text-dark btn-sm btn-icon-md btn-circle down-count ">-</span>
                        <input type="number" value="1" class="form-control text-center text-count "/>
                        <span class="input-group-text btn  btn-light-secondary btn-outline text-center text-dark  up-count btn-sm btn-icon-md btn-circle ">+</span>
                    </div>

                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-primary save-btn">Lưu lại</button>
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div>
    <div id="modal-add-detail" class="modal fade" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title-add-detail"></h3>
                    <!--begin::Close-->
                    <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal"
                         aria-label="Close">
                        <span class="svg-icon svg-icon-1"></span>
                    </div>
                    <!--end::Close-->
                </div>
                <div class="modal-body">
                    <div hidden class="mb-10">
                        <label class="required form-label">Id Hoá Đơn</label>
                        <input data-action="" readonly type="text"
                               class="form-control form-control-solid id-invoice-modal" placeholder="Example input"/>
                    </div>
                    <div class="mb-10">
                        <div class="mb-10">
                            <label class="required form-label">Chọn Sản Phẩm</label>
                            <select class="form-select select-2-product form-select-solid" data-control="select2"
                                    data-placeholder="Chọn sản phẩm">
                                <c:forEach items="${products}" var="product">
                                    <option data-name="${product.productName}" data-price="${product.price}"
                                            value="${product.id}">${product.productName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="input-group mb-5">
                        <span class="input-group-text me-2" id="basic-addon3">Số lượng</span>
                        <span class="input-group-text btn  btn-light-secondary btn-outline text-center text-dark btn-sm btn-icon-md btn-circle down-count "
                              id="down-count">-</span>
                        <input type="number" value="1" class="form-control text-center text-count " id="count"/>
                        <span class="input-group-text btn  btn-light-secondary btn-outline text-center text-dark  up-count btn-sm btn-icon-md btn-circle "
                              id="up-count">+</span>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary save-btn-add-detail">Lưu lại</button>
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../includes/footer.jsp"></jsp:include>
<jsp:include page="../includes/end.jsp"></jsp:include>
<script>
    //handel delete-btn
    $(document).on("click", ".delete-btn", function (e) {
        var id = $(this).attr("data-action");
        var that = $(this);
        var row = that.closest("tr");
        swal.fire({
            title: "Bạn có chắc chắn muốn xóa?",
            text: "Sau khi xóa, bạn sẽ không thể phục hồi dữ liệu này!",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33",
            confirmButtonText: "Đồng ý",
            cancelButtonText: "Hủy bỏ",
        }).then((result) => {
            if (result.value) {
                $.ajax({
                    url: "/detailInvoice/delete/" + id,
                    type: "GET",
                    success: function (result) {
                        if (result.check == true) {
                            toastr.success("Xóa thành công");
                            row.remove();
                        } else {
                            toastr.error("Xóa thất bại");
                        }
                    }
                });
            }
        });
    });
    $(document).on("click", ".btn-edit", function () {
        $('.modal-title').text("Sửa chi tiết hoá đơn " + $(this).attr("data-action"));
        $('.id-detail-invoice').val($(this).attr("data-action"));
        $('.id-detail-invoice').attr("data-action", $(this).attr("data-action"));
        $('.id-product-invoice').val($(this).closest("tr").find(".id-product-tabel").text());
        $('.text-count').val($(this).closest("tr").find(".quantity-table").text());
        $('#modal-edit-detail').modal('show');
    });
    //hadle up-count
    $(document).on("click", ".up-count", function () {
        var count = $('.text-count').val();
        count++;
        $('.text-count').val(count);
    });
    //hadle down-count
    $(document).on("click", ".down-count", function () {
        var count = $('.text-count').val();
        if (count > 1) {
            count--;
            $('.text-count').val(count);
        }
    });
    //handel save-btn
    $(document).on("click", ".save-btn", function () {
        var id = $('.id-detail-invoice').attr("data-action");
        var quantity = $('.text-count').val();
        let data = {
            idDetailInvoice: id,
            quantity: quantity
        };
        $.ajax({
            url: "/detailInvoice/" + id,
            contentType: "application/json",
            type: "PUT",
            data: JSON.stringify(data),
            success: function (result) {
                if (result.check == true) {
                    toastr.success("Cập nhật thành công");
                    //find row and update
                    var row = $('.id-detail-invoice-' + id);
                    row.find(".quantity-table").text(quantity);
                    row.find(".total-money-price").text(validatePriceToVND(parseInt(quantity) * parseInt(row.find(".id-product-tabel").attr("data-price"))));
                    toastr.success("Cập nhật thành công");
                    $('#modal-edit-detail').modal('hide');
                    setTimeout(function () {
                        window.location.reload();
                    }, 1000);

                } else {
                    toastr.error("Cập nhật thất bại");
                }
            }
        });
    });
    let validatePriceToVND = (price) => {
        return new Intl.NumberFormat('vi-VN', {style: 'currency', currency: 'VND'}).format(price)
    }
    $('.select-2-product').select2();
    //handel add-detail
    $(document).on("click", ".add-detail", function () {
        $('.modal-title-add-detail').text("Thêm chi tiết hoá đơn");
        $('.id-invoice-modal').val($('.id-invoice').val());
        // $('.text-count').val("1");
        $('#modal-add-detail').modal('show');
    });
    //handel save-btn-add-detail
    $(document).on("click", ".save-btn-add-detail", function () {
        var id = $('.id-invoice-modal').val();
        var quantity = $('.text-count').val();
        var idProduct = $('.select-2-product').val();
        let data = {
            idInvoice: id,
            idProduct: idProduct,
            quantity: quantity
        }
        console.log(JSON.stringify(data));
        $.ajax({
            url: "/detailInvoice/store",
            method: "POST",
            contentType: "application/json",
            data: JSON.stringify(data),
            success: function (result) {
                if (result.check == true) {
                    toastr.success("Cập nhật thành công");
                    setTimeout(function () {
                        window.location.reload();
                    }, 1000);
                }
            }
        })
    });
    //handel save-name-invoice
    $(document).on("click", ".save-name-invoice", function () {
        var id = $('.id-invoice').val();
        var name = $('.name-customer-invoice').val();
        let data = {
            idInvoice: id,
            customerName: name
        }
        $.ajax({
            url: "/invoice/" + id,
            method: "PUT",
            contentType: "application/json",
            data: JSON.stringify(data),
            success: function (result) {
                if (result.check == true) {
                    toastr.success("Cập nhật thành công");
                    setTimeout(function () {
                        window.location.reload();
                    }, 2000);
                }
            }
        })
    });

    ///sum total money in all row



</script>