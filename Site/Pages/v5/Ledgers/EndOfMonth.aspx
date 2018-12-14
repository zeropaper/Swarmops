﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Master-v5.master" AutoEventWireup="true" CodeBehind="EndOfMonth.aspx.cs" Inherits="Swarmops.Frontend.Pages.Ledgers.EndOfMonth" %>


<asp:Content ID="Content1" ContentPlaceHolderID="PlaceHolderHead" runat="server">
    
    <script type="text/javascript">


        $(document).ready(function () {

            var rowCount = 0;

            <%=this.JavascriptDocReady%>

            // set action icons to their respective initial icons

            $('img.eomitem-document').attr('src', '/Images/Icons/iconshock-balloon-invoice-128x96px.png');
            $('img.eomitem-upload').attr('src', '/Images/Icons/iconshock-upload-128x96px.png');

            // pointer cursor over action icons

            $('img.action').attr('cursor', 'hand');

            $('#TableEomItems').datagrid('appendRow', {
                itemGroupName: '<span class="itemGroupHeader">Upload&nbsp;external&nbsp;data&nbsp;and&nbsp;match&nbsp;accounts</span>',
                itemId: 'GroupExternal'
            });

            rowCount = $('#TableEomItems').datagrid('getRows').length;

            $('#TableEomItems').datagrid('mergeCells', {
                index: rowCount - 1,
                colspan: 2,
                type: 'body',
                field: 'itemGroupName'
            });


            $('#TableEomItems').datagrid('appendRow', {
                itemName: 'Upload/Fetch bank transaction data (FORMAT) up until [lastdatelastmonth]',
                action: "<img src='/Images/Icons/iconshock-yellow-sphere-30pct-128x96px.png' data-test-id='Sockets-Browser' class='test-running' style='display:inline' height='20px' />"
            });

            $('#TableEomItems').datagrid('appendRow', {
                itemName: 'Upload bank statement (PDF) for [lastmonth]',
                action: "<img src='/Images/Icons/iconshock-yellow-sphere-30pct-128x96px.png' data-test-id='Sockets-Browser' class='test-running' style='display:inline' height='20px' />"
            });

            $('#TableEomItems').datagrid('appendRow', {
                itemName: 'Resolve unmatched ledger transactions',
                action: "<img src='/Images/Icons/iconshock-yellow-sphere-30pct-128x96px.png' data-test-id='Sockets-Browser' class='test-running' style='display:inline' height='20px' />"
            });

            $('#TableEomItems').datagrid('appendRow', {
                itemGroupName: '<span class="itemGroupHeader">Taxes&nbsp;and&nbsp;Payroll</span>',
                itemId: 'GroupTaxesPayroll'
            });

            rowCount = $('#TableEomItems').datagrid('getRows').length;

            $('#TableEomItems').datagrid('mergeCells', {
                index: rowCount - 1,
                colspan: 2,
                type: 'body',
                field: 'itemGroupName'
            });

            $('#TableEomItems').datagrid('appendRow', {
                itemName: 'VAT Report for [lastmonth]',
                action: "<img src='/Images/Icons/iconshock-yellow-sphere-30pct-128x96px.png' data-test-id='Sockets-Browser' class='test-running' style='display:inline' height='20px' />"
            });

            /*

            $('#TableEomItems').datagrid('appendRow', {
                itemName: 'Payroll processing for [thismonth]',
                docs: "<img src='/Images/Icons/iconshock-red-cross-sphere-128x96px.png' data-test-id='Sockets-Browser' class='test-failed' style='display:none' height='20px' />",
                actions: "<img src='/Images/Icons/iconshock-yellow-sphere-30pct-128x96px.png' data-test-id='Sockets-Browser' class='test-running' style='display:inline' height='20px' />"
            });

            $('#TableEomItems').datagrid('appendRow', {
                itemName: 'Submit to tax authorities',
                docs: "<img src='/Images/Icons/iconshock-red-cross-sphere-128x96px.png' data-test-id='Sockets-Browser' class='test-failed' style='display:none' height='20px' />",
                actions: "<img src='/Images/Icons/iconshock-yellow-sphere-30pct-128x96px.png' data-test-id='Sockets-Browser' class='test-running' style='display:inline' height='20px' />"
            });

            */

            $('#TableEomItems').datagrid('appendRow', {
                itemGroupName: '<span class="itemGroupHeader">Annual&nbsp;Reports</span>',
                itemId: 'GroupAnnual'
            });

            rowCount = $('#TableEomItems').datagrid('getRows').length;

            $('#TableEomItems').datagrid('mergeCells', {
                index: rowCount - 1,
                colspan: 2,
                type: 'body',
                field: 'itemGroupName'
            });

            $('#TableEomItems').datagrid('appendRow', {
                itemName: 'Close ledgers for [year]',
                docs: "<img src='/Images/Icons/iconshock-red-cross-sphere-128x96px.png' data-test-id='Sockets-Browser' class='test-failed' style='display:none' height='20px' />",
                action: "<img src='/Images/Icons/iconshock-yellow-sphere-30pct-128x96px.png' data-test-id='Sockets-Browser' class='test-running' style='display:inline' height='20px' />"
            });


            $('#TableEomItems').datagrid('appendRow', {
                itemGroupName: '<span class="itemGroupHeader">Send&nbsp;to&nbsp;Accountants,&nbsp;Shareholders,&nbsp;etc.</span>',
                itemId: 'SendReports'
            });

            rowCount = $('#TableEomItems').datagrid('getRows').length;

            $('#TableEomItems').datagrid('mergeCells', {
                index: rowCount - 1,
                colspan: 2,
                type: 'body',
                field: 'itemGroupName'
            });

            $('#TableEomItems').datagrid('appendRow', {
                itemName: 'Send all reports as required',
                docs: "<img src='/Images/Icons/iconshock-red-cross-sphere-128x96px.png' data-test-id='Sockets-Browser' class='test-failed' style='display:none' height='20px' />",
                action: "<img src='/Images/Icons/iconshock-yellow-sphere-30pct-128x96px.png' data-test-id='Sockets-Browser' class='test-running' style='display:inline' height='20px' />"
            });

            $('.action').click(function() {
                var itemId = $(this).attr('data-item');
                var callbackFunction = $(this).attr('data-callback');

                if ($(this).hasClass('is-upload')) {

                    // Trigger upload, then trigger ajax call on complete

                    if (triggeredUpload != null) {
                        // upload is already in progress; don't allow two concurrent uploads since we're using one control
                        // todo: error message or some UX to explain this?

                        return;
                    }

                    triggeredUpload = this;
                    <%=this.UploadControl.ClientID%>_triggerUpload();

                } else {

                    // Ajax call right away

                    $('img.action-icon[data-item="' + itemId + '"]').hide();
                    $('img.status-icon-pleasewait[data-item="' + itemId + '"]').show();

                    SwarmopsJS.ajaxCall(
                        "/Pages/v5/Ledgers/EndOfMonth.aspx/" + callbackFunction,
                        {},
                        $.proxy(function() {
                            var groupId = $(this).attr('data-group');
                            var itemId = $(this).attr('data-item');

                            $('span.action-list-item[data-item="' + itemId + '"]').addClass('action-list-item-completed');
                            $('img.status-icon-pleasewait[data-item="' + itemId + '"]').hide();
                            $('img.status-icon-completed[data-item="' + itemId + '"]').fadeIn();

                            var selector = ".action-list-item:not(.action-list-item-completed):not(.action-list-item-disabled)[data-group='" + groupId + "']";
                            if ($(selector).length == 0) // no further actions in this group enabled
                            {
                                // mark the group as completed
                                $(".group-status-icon[data-group='" + groupId + "']").fadeIn();
                            }
                        }, this)
                    );
                }

            });

            $('.action-skip > a').click(function () {
                var itemId = $(this).parent().parent().attr("data-item");
                var dependentItemId = $('span.action-list-item[data-dependson="' + itemId + '"]').attr("data-item");

                $('img.action-icon[data-item="' + itemId + '"]').hide();
                $('img.status-icon-completed[data-item="' + itemId + '"]').attr("src", "/Images/Icons/iconshock-red-cross-128x96px.png").fadeIn();

                $('span.action-list-item[data-item="' + itemId + '"]').addClass('action-list-item-completed');
                $('span.action-list-item[data-item="' + dependentItemId + '"]').removeClass('action-list-item-disabled');
                $('img.action-icon[data-item="' + dependentItemId + '"]').removeClass('action-icon-disabled');
            });

        });

        function clientStartUpload() {
            if (triggeredUpload == null) {
                // invalid state
                return;
            }

            var itemId = $(triggeredUpload).attr('data-item');
            $('img.action-icon[data-item="' + itemId + '"]').hide();
            $('img.status-icon-pleasewait[data-item="' + itemId + '"]').show();
        }

        function clientFailUpload() {
            if (triggeredUpload == null) {
                // invalid state
                return;
            }

            var itemId = $(triggeredUpload).attr('data-item');
            $('img.status-icon-pleasewait[data-item="' + itemId + '"]').hide();
            $('img.action-icon[data-item="' + itemId + '"]').show();

            triggeredUpload = null;
        }

        function clientFinishUpload() {
            if (triggeredUpload == null) {
                // invalid state
                return;
            }

            triggeredUpload = null;
        }

        var uploadGuid = '<%=this.UploadControl.GuidString%>';

        var triggeredUpload = null;


        // Function: Match all mismatched transactions

        // Function: Upload bank statement PDF for accountId x

        // Function: Close YEAR if a new year

        // Function: Send EOM papers to accountants etc


    </script>

    <style type="text/css">
        .itemGroupHeader {
            font-size: 125%;
            font-weight: 500;
        }

        .action-icon {
            -webkit-transition: all 0.50s;
            transition: all 0.50s;
            border: 1px solid transparent;
            width: 26px;
            height: 20px;
            cursor: pointer;
        }

        .status-icon {
            border: 1px solid transparent;
            width: 26px;
            height: 20px;
        }

        .group-status-icon {
            width: 32px;
            height: 24px;
        }

        .action-icon:hover {
            border: 1px solid #FFD580;
            background: #FFEDC8;
            filter: brightness(105%) contrast(105%);
            -webkit-filter: brightness(105%) contrast(105%);
            -moz-filter: brightness(105%) contrast(105%);
            -o-filter: brightness(105%) contrast(105%);
            -ms-filter: brightness(105%) contrast(105%);
            /*-webkit-transition: all 0.50s;
            transition: all 0.50s;*/
        }

        .action-list-item-disabled .action-skip, .action-list-item-completed .action-skip {
            -webkit-transition: all 0.50s;
            transition: all 0.50s;
            display: none;
        }

        .action-list-item-completed {
            -webkit-transition: all 0.50s;
            transition: all 0.50s;
            color: #ccc;
            text-decoration: line-through;
        }

        .action-list-item-disabled {
            -webkit-transition: all 0.50s;
            transition: all 0.50s;
            color: #aaa;
        }

        .action-icon-disabled {
            display: none !important;
        }

        .datagrid-row-selected, .datagrid-row-over, .datagrid-row-checked {
            background:transparent !important;
        }
    </style>


</asp:Content>




<asp:Content ID="Content2" ContentPlaceHolderID="PlaceHolderMain" runat="server">
    <h2><asp:Label runat="server" ID="LabelHeader"></asp:Label></h2>
    <div style="display: none"><Swarmops5:FileUpload ID="UploadControl" runat="server"/></div>

    <table id="TableEomItems" class="easyui-datagrid" style="width:680px;height:500px"
        data-options="rownumbers:false,singleSelect:false,nowrap:false,fit:false,loading:false,selectOnCheck:false,checkOnSelect:false"
        idField="itemId">
        <thead>
            <tr>
                <th data-options="field:'itemGroupName',width:42">&nbsp;</th>
                <th data-options="field:'itemName',width:562">Todo</th>
                <th data-options="field:'action',width:55,align:'center'">Action</th>
            </tr>  
        </thead>
    </table>  
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="PlaceHolderSide" Runat="Server">
</asp:Content>

