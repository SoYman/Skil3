#include "sqlinterfacemodel.h"

#include <QDebug>
#include <QSqlError>
#include <QSqlRecord>
#include <QSqlQuery>
#include <QSqlField>

SqlInterfaceModel::SqlInterfaceModel(QObject *parent) : QSqlRelationalTableModel(parent) {
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
        _is_relational = false;
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
        _is_relational = false;
    } else if (tableName == "Relations") {
        if (!QSqlDatabase::database().tables().contains(tableName) &&
                !query.exec(
                    "CREATE TABLE IF NOT EXISTS Relations ("
                    "id INTEGER PRIMARY KEY AUTOINCREMENT,"
                    "computer_id INTEGER NOT NULL,"
                    "person_id INTEGER NOT NULL,"
                    "relationship TEXT,"
                    "UNIQUE (computer_id, person_id))R")) {
            qFatal("Failed to query database: %s", qPrintable(query.lastError().text()));
        }
        _is_relational = true;
    }
    empty = true;

    QSqlRelationalTableModel::setTable(tableName);
    setSort(0, _sort_order);
    setEditStrategy(QSqlRelationalTableModel::OnManualSubmit);
    if (_is_relational) {

        setRelation(1, QSqlRelation("Computers", "id", "name"));
        setRelation(2, QSqlRelation("People", "id", "name"));
    }
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
    if (_is_relational) {
        QSqlRelationalTableModel::setFilter(_filter_type + " = " + _filter);
    } else {
        QString likeCommand;
        if (_filter_type == "Gender") {
            likeCommand = " LIKE '";
        } else {
            likeCommand = " LIKE '%";
        }
        if (_filter == "") {
            QSqlRelationalTableModel::setFilter("");
        } else {
            QSqlRelationalTableModel::setFilter(_filter_type + likeCommand + _filter + "%'");
        }
    }
    select();
    emit filterChanged();
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

qint64 SqlInterfaceModel::relationColumn() const
{
    return _relation_column;
}

void SqlInterfaceModel::setRelationColumn(qint64 &relationColumn)
{
    _relation_column = relationColumn;

    emit relationColumnChanged();
}

QVariant SqlInterfaceModel::data(const QModelIndex &idx, int role) const
{
    if (role < Qt::UserRole) {
        return QSqlRelationalTableModel::data(idx, role);
    }
    const QSqlRecord sqlRecord = record(idx.row());

    return sqlRecord.value(role - Qt::UserRole);
}

QHash<int, QByteArray> SqlInterfaceModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[id] = "id";
    if (_table == "Computers") {
        roles[name] = "name";
        roles[year] = "year";
        roles[type] = "type";
        roles[made] = "made";
    } else if (_table == "People") {
        roles[name] = "name";
        roles[born] = "born";
        roles[died] = "died";
        roles[gender] = "gender";
        roles[nationality] = "nationality";
    } else if (_table == "Relations") {
        roles[computer_id] = "computer_id";
        roles[person_id] = "person_id";
        roles[relationship] = "relationship";
    }
    return roles;
}

bool SqlInterfaceModel::insertRow(int row)
{
    emit beginInsertRows(index(row, 0), row, row);
    bool success = false;
    // If new entry hasn't been changed, don't add another one
    if (!isDirty()) {
        success = QSqlRelationalTableModel::insertRow(row);
    }
    return success;
    emit endInsertRows();
}

void SqlInterfaceModel::setIdSort()
{
    setSort(0, Qt::DescendingOrder);
    select();
}

void SqlInterfaceModel::setValue(const QString &field, const QVariant &val)
{
    QSqlRecord sqlRecord = record(_working_row);
    sqlRecord.setGenerated(field, true);
    sqlRecord.setValue(field, val);

    setRecord(_working_row, sqlRecord);
    //emit dataChanged();
    submitAll();
}

bool SqlInterfaceModel::removeWorkingRow()
{
    bool success = removeRow(_working_row);
    submitAll();
    select();
    return success;
}

void SqlInterfaceModel::makeRelation(const qint64 &computerId, const qint64 &personId)
{
    if (_is_relational) {
        QSqlRecord sqlRecord = record(0);
        sqlRecord.setGenerated("id", false);
        qDebug() << sqlRecord.fieldName(0) << sqlRecord.fieldName(1) << sqlRecord.fieldName(2);
        sqlRecord.setValue(1, QVariant(computerId));
        sqlRecord.setValue(2, QVariant(personId));
        qDebug() <<
        insertRecord(-1, sqlRecord);
        qDebug() <<
        submitAll();
        sort(0, _sort_order);
        select();
    }
}
