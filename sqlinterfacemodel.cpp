#include "sqlinterfacemodel.h"

#include <QDebug>
#include <QSqlError>
#include <QSqlRecord>
#include <QSqlQuery>
#include <QSqlField>

SqlInterfaceModel::SqlInterfaceModel(QObject *parent) : QSqlTableModel(parent) {}

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
                        "name TEXT,"
                        "year INTEGER,"
                        "type TEXT,"
                        "made INTEGER)")) {
                qFatal("Failed to query database: %s", qPrintable(query.lastError().text()));
            } else {
                empty = true;
            }
        }
    } else if (tableName == "People") {
        if (!QSqlDatabase::database().tables().contains(tableName)) {
            if (!query.exec(
                        "create table if not exists People ("
                        "id INTEGER primary key autoincrement,"
                        "name TEXT,"
                        "born INTEGER,"
                        "died TEXT,"
                        "gender TEXT,"
                        "nationality TEXT)")) {
                qFatal("Failed to query database: %s", qPrintable(query.lastError().text()));
            } else {
                empty = true;
            }
        }
    } else if (tableName == "Relations") {
        if (!QSqlDatabase::database().tables().contains(tableName) &&
                !query.exec(
                    "create table if not exists Relations ("
                    "id INTEGER primary key autoincrement"
                    "computer_id INTEGER"
                    "person_id INTEGER"
                    "relationship TEXT)")) {
            qFatal("Failed to query database: %s", qPrintable(query.lastError().text()));
        }
    }

    QSqlTableModel::setTable(tableName);
    setSort(0, Qt::DescendingOrder);
    setEditStrategy(QSqlTableModel::OnFieldChange);
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
    qDebug() << QSqlTableModel::filter();
}

QString SqlInterfaceModel::filterType() const
{
    return _filter_type;
}

void SqlInterfaceModel::setFilterType(const QString &filterType)
{
    if (filterType.toLower() == _filter_type) {
        return;
    }

    _filter_type = filterType.toLower();

    setFilter(_filter);

    setSort(fieldIndex(_filter_type), Qt::DescendingOrder);
    select();

    emit filterTypeChanged();
}

qint64 SqlInterfaceModel::workingRow() const
{
    return _working_row;
}

void SqlInterfaceModel::setWorkingRow(qint64 &workingRow)
{
    _working_row = workingRow;
    qDebug() << "the working id is " << _working_row << endl;
    emit workingRowChanged();
}

QVariant SqlInterfaceModel::data(const QModelIndex &idx, int role) const
{
    qDebug() << QVariant(idx.row()) << "\t" << role - Qt::UserRole;
    if (role < Qt::UserRole) {
        return QSqlTableModel::data(idx, role);
    }

    const QSqlRecord sqlRecord = record(idx.row());
    //qDebug() << "data: " << sqlRecord.value(role - Qt::UserRole) << endl;
    int finalRole = role - Qt::UserRole;

    // QSqlTableModel and Qt Quick 2 don't like sharing row numbers
    if (finalRole == 0) {
        return QVariant(idx.row());
    } else {
        return sqlRecord.value(finalRole - 1);
    }
}

//bool SqlInterfaceModel::setData(const QModelIndex &idx, const QVariant &val, int role)
//{
//    if (role < Qt::UserRole) {
//        return QSqlTableModel::setData(idx, val, role);
//    }

//    QSqlRecord sqlRecord = record(idx.row());
//    qDebug() << "data was: " << sqlRecord.value(role - Qt::UserRole) << endl;
//    sqlRecord.setValue(role - Qt::UserRole, val);
//    qDebug() << "data is:  " << sqlRecord.value(role - Qt::UserRole) << endl;
//    return setRecord(idx.row(), sqlRecord);
//}

QHash<int, QByteArray> SqlInterfaceModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Qt::UserRole] = "row";
    roles[Qt::UserRole + 1] = "id";
    roles[Qt::UserRole + 2] = "name";
    if (_table == "Computers") {
        roles[Qt::UserRole + 3] = "year";
        roles[Qt::UserRole + 4] = "type";
        roles[Qt::UserRole + 5] = "made";
    } else if (_table == "People") {
        roles[Qt::UserRole + 3] = "born";
        roles[Qt::UserRole + 4] = "died";
        roles[Qt::UserRole + 5] = "gender";
        roles[Qt::UserRole + 6] = "nationality";
    }
    return roles;
}

void SqlInterfaceModel::setValue(const QString &field, const QVariant &val)
{
    QSqlRecord sqlRecord = record(_working_row);
    //qDebug() << "data was: " << sqlRecord.value(field) << endl;
    for (int i = 0; i < sqlRecord.count(); i++) {
        //qDebug() << sqlRecord.value(i) << endl;
        sqlRecord.setGenerated(i, false);
    }
    sqlRecord.setGenerated(field, true);
    sqlRecord.setValue(field, val);

    //qDebug() << "data is:  " << sqlRecord.value(field) << endl;
    //qDebug() << "the working id is " << _working_row << endl;
    qDebug() << setRecord(_working_row, sqlRecord);
    //submit();
}
