package com.java04.wibucian.vos;

import lombok.Data;

import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.Date;


@Data
public class InvoiceVO implements Serializable {
    private static final long serialVersionUID = 1L;

    @NotNull(message = "id can not null")
    private Integer id;

    @NotNull(message = "idInvoice can not null")
    private String idInvoice;

    private String idEmployee;

    private String idGroupTable;

    @NotNull(message = "customerName can not null")
    private String customerName;

    private Float toltalMoney;

    private Date dateTime;

}