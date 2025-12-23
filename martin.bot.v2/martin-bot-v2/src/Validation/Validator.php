<?php

namespace App\Validation;

class Validator
{
    protected array $errors = [];

    public function validate(array $data, array $rules): bool
    {
        $this->errors = [];

        foreach ($rules as $field => $ruleString) {
            $value = $data[$field] ?? null;
            $this->validateField($field, $value, $ruleString);
        }

        return empty($this->errors);
    }

    public function validateField(string $field, $value, string $ruleString): bool
    {
        $ruleList = explode('|', $ruleString);

        foreach ($ruleList as $rule) {
            $this->applyRule($field, $value, $rule);
        }

        return empty($this->errors[$field] ?? []);
    }

    protected function applyRule(string $field, $value, string $rule): void
    {
        [$ruleName, $param] = array_pad(explode(':', $rule, 2), 2, null);

        switch ($ruleName) {
            case 'required':
                if ($value === null || $value === '') {
                    $this->addError($field, "Поле {$field} обязательно");
                }
                break;

            case 'string':
                if ($value !== null && !is_string($value)) {
                    $this->addError($field, "Поле {$field} должно быть строкой");
                }
                break;

            case 'strlen':
                if (is_string($value)) {
                    [$min, $max] = array_pad(explode(',', $param), 2, null);

                    $len = mb_strlen($value);

                    if ($min !== null && $len < (int)$min) {
                        $this->addError($field, "Поле {$field} должно содержать минимум {$min} символов");
                    }

                    if ($max !== null && $len > (int)$max) {
                        $this->addError($field, "Поле {$field} должно содержать не больше {$max} символов");
                    }
                }
                break;

            case 'no_digits':
                if ($value !== null && is_string($value) && preg_match('/\p{Nd}/u', $value)) {
                    $this->addError($field, "Поле {$field} не должно содержать цифры");
                }
                break;

            case 'int':
            case 'integer':
                if ($value !== null && filter_var($value, FILTER_VALIDATE_INT) === false) {
                    $this->addError($field, "Поле {$field} должно быть целым числом");
                }
                break;

            case 'min':
                if (is_numeric($value) && $value < (int)$param) {
                    $this->addError($field, "Поле {$field} должно быть не меньше {$param}");
                } elseif (is_string($value) && mb_strlen($value) < (int)$param) {
                    $this->addError($field, "Поле {$field} должно содержать минимум {$param} символов");
                }
                break;

            case 'max':
                if (is_numeric($value) && $value > (int)$param) {
                    $this->addError($field, "Поле {$field} должно быть не больше {$param}");
                } elseif (is_string($value) && mb_strlen($value) > (int)$param) {
                    $this->addError($field, "Поле {$field} должно содержать не больше {$param} символов");
                }
                break;

            case 'mac':
                if ($value !== null) {
                    $pattern = '/^([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}$/';
                    if (!preg_match($pattern, $value)) {
                        $this->addError($field, "Поле {$field} должно быть корректным MAC-адресом в формате XX:XX:XX:XX:XX:XX");
                    }
                }
                break;

        }
    }

    protected function addError(string $field, string $message): void
    {
        $this->errors[$field][] = $message;
    }

    public function errors(string $field = null): array
    {
        if ($field !== null) {
            return $this->errors[$field] ?? [];
        }
        return $this->errors;
    }

    public function errorsAsString(string $separator = "; \n"): string
    {
        $all = [];
        foreach ($this->errors as $fieldErrors) {
            foreach ($fieldErrors as $message) {
                $all[] = $message;
            }
        }
        return implode($separator, $all);
    }
}