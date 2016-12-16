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

qint64 SqlInterfaceModel::workingId() const
{
    return _working_id;
}

void SqlInterfaceModel::setWorkingId(qint64 &workingId)
{
    _working_id = workingId;
    qDebug() << "the working id is " << _working_id << endl;
    emit workingIdChanged();
}

QVariant SqlInterfaceModel::data(const QModelIndex &idx, int role) const
{
    if (role < Qt::UserRole) {
        return QSqlTableModel::data(idx, role);
    }

    const QSqlRecord sqlRecord = record(idx.row());
    qDebug() << "data: " << sqlRecord.value(role - Qt::UserRole) << endl;
    return sqlRecord.value(role - Qt::UserRole);
}

QHash<int, QByteArray> SqlInterfaceModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    if (_table == "Computers") {
        roles[Qt::UserRole] = "id";
        roles[Qt::UserRole + 1] = "name";
        roles[Qt::UserRole + 2] = "year";
        roles[Qt::UserRole + 3] = "type";
        roles[Qt::UserRole + 4] = "made";
    } else if (_table == "People") {
        roles[Qt::UserRole] = "id";
        roles[Qt::UserRole + 1] = "name";
        roles[Qt::UserRole + 2] = "born";
        roles[Qt::UserRole + 3] = "died";
        roles[Qt::UserRole + 4] = "gender";
        roles[Qt::UserRole + 5] = "nationality";
    }
    return roles;
}
