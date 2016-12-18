import QtQuick 2.7
import QtQuick.Controls 2.0

SpinBox {
    //activeFocusOnTab: true
    textFromValue: function(value) { return value }
    Keys.onBacktabPressed: {
//        value =
    }
}
