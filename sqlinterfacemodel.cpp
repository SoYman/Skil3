#include "sqlinterfacemodel.h"

#include <QDebug>
#include <QSqlError>
#include <QSqlRecord>
#include <QSqlQuery>
#include <QSqlField>

SqlInterfaceModel::SqlInterfaceModel(QObject *parent) : QSqlTableModel(parent) {
    _sort_order = Qt::DescendingOrder;
}

QString SqlInterfaceModel::table() const
{
    return _table;
}

void SqlInterfaceModel::setTable(const QString &tableName)
{
    _table = tableName;
    bool empty = false;
    QSqlQuery query;
    if (tableName == "Computers") {
        if (!QSqlDatabase::database().tables().contains("Computers")) {
            if (!query.exec(
                        "create table if not exists Computers ("
                        "id INTEGER primary key autoincrement,"
                        "name TEXT NOT NULL,"
                        "year INTEGER,"
                        "type TEXT,"
                        "made INTEGER)")) {
                qFatal("Failed to query database: %s", qPrintable(query.lastError().text()));
            }
        }
    } else if (tableName == "People") {
        if (!QSqlDatabase::database().tables().contains(tableName)) {
            if (!query.exec(
                        "create table if not exists People ("
                        "id INTEGER primary key autoincrement,"
                        "name TEXT NOT NULL,"
                        "born INTEGER,"
                        "died INTEGER,"
                        "gender TEXT,"
                        "nationality TEXT)")) {
                qFatal("Failed to query database: %s", qPrintable(query.lastError().text()));
            }
        }
    } else if (tableName == "Relations") {
        if (!QSqlDatabase::database().tables().contains(tableName) &&
                !query.exec(
                    "create table if not exists Relations ("
                    "id INTEGER primary key autoincrement"
                    "computer_id INTEGER NOT NULL"
                    "person_id INTEGER NOT NULL"
                    "relationship TEXT)")) {
            qFatal("Failed to query database: %s", qPrintable(query.lastError().text()));
        }
    }
        empty = true;

    QSqlTableModel::setTable(tableName);
    setSort(0, _sort_order);
    setEditStrategy(QSqlTableModel::OnManualSubmit);
    if (empty) {
        QSqlRecord rec = record();
        if (tableName == "Computers") {
            rec.setValue("name", "Earth Simulator");
            rec.setValue("year", 2002);
            rec.setValue("type", "Vector");
            rec.setValue("made", 1);
        } else if (tableName == "People") {
            rec.setValue("name", "Grace Hopper");
            rec.setValue("born", 1906);
            rec.setValue("died", 1992);
            rec.setValue("gender", "Female");
            rec.setValue("nationality", "United States");
        }
        insertRecord(-1, rec);
    }
    select();
}

QString SqlInterfaceModel::filter() const
{
    return _filter;
}

void SqlInterfaceModel::setFilter(const QString &filter)
{
    _filter = filter;
    QString likeCommand;
    if (_filter_type == "gender") {
        likeCommand = " LIKE '";
    } else {
        likeCommand = " LIKE '%";
    }
    if (_filter == "") {
        QSqlTableModel::setFilter("");
    } else {
        QSqlTableModel::setFilter(_filter_type + likeCommand + _filter + "%'");
    }

    select();
    emit filterChanged();
    //qDebug() << QSqlTableModel::filter();
}

QString SqlInterfaceModel::filterType() const
{
    return _filter_type;
}

void SqlInterfaceModel::setFilterType(const QString &filterType)
{
    // if the same filter is selected the order is swapped
    if (filterType == _filter_type) {
        if (_sort_order == Qt::DescendingOrder) {
            _sort_order = Qt::AscendingOrder;
        } else {
            _sort_order = Qt::DescendingOrder;
        }
    } else {
        _sort_order = Qt::DescendingOrder;
    }

        _filter_type = filterType;

        setFilter(_filter);

    setSort(fieldIndex(_filter_type), _sort_order);
    select();
    emit filterTypeChanged();
    qDebug() << filterType << " and " << orderByClause();
}

qint64 SqlInterfaceModel::workingRow() const
{
    return _working_row;
}

void SqlInterfaceModel::setWorkingRow(qint64 &workingRow)
{
    _working_row = workingRow;
    emit workingRowChanged();
}

QVariant SqlInterfaceModel::data(const QModelIndex &idx, int role) const
{
    //qDebug() << QVariant(idx.row()) << "\t" << role - Qt::UserRole;
    if (role < Qt::UserRole) {
        return QSqlTableModel::data(idx, role);
    }

    const QSqlRecord sqlRecord = record(idx.row());
    //qDebug() << "data: " << sqlRecord.value(role - Qt::UserRole) << endl;

    return sqlRecord.value(role - Qt::UserRole);
}

QHash<int, QByteArray> SqlInterfaceModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Qt::UserRole] = "id";
    roles[Qt::UserRole + 1] = "name";
    if (_table == "Computers") {
        roles[Qt::UserRole + 2] = "year";
        roles[Qt::UserRole + 3] = "type";
        roles[Qt::UserRole + 4] = "made";
    } else if (_table == "People") {
        roles[Qt::UserRole + 2] = "born";
        roles[Qt::UserRole + 3] = "died";
        roles[Qt::UserRole + 4] = "gender";
        roles[Qt::UserRole + 5] = "nationality";
    }
    return roles;
}

bool SqlInterfaceModel::insertRow(int row)
{
    bool success = false;
    // If new entry hasn't been changed, don't add another one
    if (!isDirty()) {
        success = QSqlTableModel::insertRow(row);
        qDebug() << "c++ inserted" << success;
        //_unmodified_entry = success;
        //submit();
    }
    return success;

}

void SqlInterfaceModel::setIdSort()
{
    setSort(0, Qt::DescendingOrder);
}

void SqlInterfaceModel::setValue(const QString &field, const QVariant &val)
{
    QSqlRecord sqlRecord = record(_working_row);
    //qDebug() << "data was: " << sqlRecord.value(field) << endl;
    for (int i = 0; i < sqlRecord.count(); i++) {
        //qDebug() << sqlRecord.value(i) << endl;
        //sqlRecord.setGenerated(i, false);
    }
    sqlRecord.setGenerated(field, true);
    sqlRecord.setValue(field, val);


    qDebug() << "data is:  " << sqlRecord.value(field);
    qDebug() << "the working row is " << _working_row;
    setRecord(_working_row, sqlRecord);

    qDebug() << "it submitted" << submitAll();
}

bool SqlInterfaceModel::removeWorkingRow()
{
    bool success = removeRow(_working_row);
    qDebug() << success;
    //endRemoveRows();
    if (success) {
        submitAll();
        select();
    }
    return success;
}
