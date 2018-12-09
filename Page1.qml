import QtQuick 2.7

Page1Form {
    signal qmlSignal(string message)

    button1.onClicked: {
        console.log("onClicked!!!")
        qmlSignal(textField1.text) //发送信号
    }

    function test(){
        console.log("TEST!!!")
    }

    function qmlFunction ( msg ) {
        console.log(msg) ;
        return "Hello World!" ;
    }

}
