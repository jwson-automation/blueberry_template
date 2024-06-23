

function _requestPayment(payload) {
    Bootpay.requestPayment(JSON.parse(payload))
    .then(function(res){
        if (res.event === 'confirm') {
              Bootpay.confirm()
              .then(function(confirmRes) {
                    BootpayDone(JSON.stringify(confirmRes));
              }, function(confirmRes) {
               if (confirmRes.event === 'error') { BootpayError(JSON.stringify(confirmRes)); }
               else if (confirmRes.event === 'cancel') { BootpayCancel(JSON.stringify(confirmRes)); }
              })

        }
        else if (res.event === 'issued') { BootpayIssued(JSON.stringify(res));  }
        else if (res.event === 'done') { BootpayDone(JSON.stringify(res));  }
    }, function(res) {
        if (res.event === 'error') { BootpayError(JSON.stringify(res)); }
        else if (res.event === 'cancel') { BootpayCancel(JSON.stringify(res)); }
    });
}



function _setLocale(locale) {
    Bootpay.setLocale(locale)
}

function _removePaymentWindow() {
    Bootpay.dismiss()
}


var closeEventRegistered = false; // close 이벤트가 등록되었는지 여부를 추적하는 변수

function _jsBeforeLoad() {
    _addCloseEventOnce(); // 이 함수를 호출하여 한 번만 close 이벤트를 등록하도록 함
}

function _addCloseEventOnce() {
    if (!closeEventRegistered) { // close 이벤트가 등록되어 있지 않은 경우에만 등록
        document.addEventListener('bootpayclose', function (e) {
            if (window.BootpayClose) {
                BootpayClose();
            }
        });
        closeEventRegistered = true; // close 이벤트가 이제 등록되었음을 표시
    }
}


function _requestPayment(payload) {
    Bootpay.requestPayment(JSON.parse(payload))
    .then(function(res){
        if (res.event === 'confirm') {
          if(BootpayConfirm(JSON.stringify(res))) {
            _transactionConfirm();
          } else {
            BootpayAsyncConfirm(JSON.stringify(res))
            .then(function(res){
              if(res) {
                _transactionConfirm();
              }
            }, function(res) {
            });
          }
        }
        else if (res.event === 'issued') { BootpayIssued(JSON.stringify(res));  }
        else if (res.event === 'done') { BootpayDone(JSON.stringify(res));  }
    }, function(res) {
        if (res.event === 'error') { BootpayError(JSON.stringify(res)); }
        else if (res.event === 'cancel') { BootpayCancel(JSON.stringify(res)); }
    });
}

function _requestSubscription(payload) {
    Bootpay.requestSubscription(JSON.parse(payload))
    .then(function(res){
        if (res.event === 'confirm') {
          if(BootpayConfirm(JSON.stringify(res))) {
            _transactionConfirm();
          }
        }
        else if (res.event === 'issued') { BootpayIssued(JSON.stringify(res));  }
        else if (res.event === 'done') { BootpayDone(JSON.stringify(res));  }
    }, function(res) {
        if (res.event === 'error') { BootpayError(JSON.stringify(res)); }
        else if (res.event === 'cancel') { BootpayCancel(JSON.stringify(res)); }
    });
}

function _requestAuthentication(payload) {
    Bootpay.requestAuthentication(JSON.parse(payload))
    .then(function(res){
        if (res.event === 'confirm') {
          if(BootpayConfirm(JSON.stringify(res))) {
            _transactionConfirm();
          }
        }
        else if (res.event === 'issued') { BootpayIssued(JSON.stringify(res));  }
        else if (res.event === 'done') { BootpayDone(JSON.stringify(res));  }
    }, function(res) {
        if (res.event === 'error') { BootpayError(JSON.stringify(res)); }
        else if (res.event === 'cancel') { BootpayCancel(JSON.stringify(res)); }
    });
}

function _transactionConfirm() {
    Bootpay.confirm()
    .then(function(res){
        if (res.event === 'issued') { BootpayIssued(JSON.stringify(res));  }
        else if (res.event === 'done') { BootpayDone(JSON.stringify(res));  }
    }, function(res) {
        if (res.event === 'error') { BootpayError(JSON.stringify(res)); }
        else if (res.event === 'cancel') { BootpayCancel(JSON.stringify(res)); }
    });
}

function _dismiss(context) {
    Bootpay.destroy();
}
