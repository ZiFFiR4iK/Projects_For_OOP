<?php

namespace App\Model;

use Doctrine\DBAL\Connection;
use Illuminate\Support\Str;

abstract class Model
{
    /**
     * The connection name for the model.
     *
     * @var string|null
     */
    protected $connection;

    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table;

    /**
     * The primary key for the model.
     *
     * @var string
     */
    protected $primaryKey = 'id';

    public bool $exists = false;

    public function newInstance($attributes = [], $exists = false)
    {
        $model = new static;

        $model->exists = $exists;

        $model->setConnection(
            $this->getConnectionName()
        );

        $model->setTable($this->getTable());

        $model->mergeCasts($this->casts);

        $model->fill((array) $attributes);

        return $model;
    }

    /**
     * Set the connection associated with the model.
     *
     * @param string|null $name
     * @return $this
     */
    public function setConnection(?string $name): static
    {
        $this->connection = $name;

        return $this;
    }

    public function getConnectionName(): ?string
    {
        return $this->connection;
    }

    public function getTable(): string
    {
        return $this->table ?? Str::snake(class_basename($this));
    }

    /**
     * Set the table associated with the model.
     *
     * @param  string  $table
     * @return $this
     */
    public function setTable(string $table): static
    {
        $this->table = $table;

        return $this;
    }
}